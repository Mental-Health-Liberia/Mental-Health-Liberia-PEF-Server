class FormConfiguration
  include Mongoid::Document
  include Mongoid::Timestamps

  validates_presence_of :body
  attr_accessible :body
  field :body,       :type => String, :default => "{}"

  validate :check_body_is_json

  protected

  def check_body_is_json
    errors.add(:body, "is not valid JSON") unless self.body.is_json?
  end
end
