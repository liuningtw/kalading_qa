class QuestionBase < ActiveRecord::Base
  belongs_to :question_category
  belongs_to :auto_brand
  belongs_to :auto_model
  belongs_to :auto_submodel
end