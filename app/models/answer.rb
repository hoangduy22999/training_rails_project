class Answer < ApplicationRecord
  belongs_to :questions,  optional: true
  before_save :downcase_fields

  validates :content, presence: true

  def downcase_fields
      self.content.downcase!
  end
end
