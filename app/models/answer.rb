class Answer < ActiveRecord::Base
  belongs_to :question, counter_cache: true
  belongs_to :replier, class_name: 'User', primary_key: 'internal_id'

  validates_presence_of :question_id, :replier_id, :replier_type, :content

  def adopt(adopter_id, adopter_type)
    if question.has_been_adopted?
      errors.add(:base, '已经有答案被采纳过了')
      return false
    end

    if adopter_type == 'customer' && question.customer_id != adopter_id
      errors.add(:base, '您没有权限采纳此答案')
      return false
    end

    self.adopter_id = adopter_id
    self.adopter_type = adopter_type
    self.adopted_at = Time.current
    question.adopt if !question.adopted?
    summary = ReplierSummary.get_summary(replier_id, Time.current)

    transaction do
      self.save!
      question.save!
      summary.after_adopt!
    end
    true
  rescue ActiveRecord::RecordInvalid
    log.warn("Adopting answer failed. Answer id: #{id}")
    false
  end

  def adopted?
    adopted_at.present?
  end

  def to_question_base
    QuestionBase.new(
      auto_brand_internal_id: question.auto_brand_internal_id,
      auto_model_internal_id: question.auto_model_internal_id,
      auto_submodel_internal_id: question.auto_submodel_internal_id,
      question_content: question.content,
      answer_content: content
    )
  end
end
