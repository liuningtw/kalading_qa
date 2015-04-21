class AutoBrand < ExternalManagement
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  attr_readonly *fields.keys

  has_many :auto_models
end
