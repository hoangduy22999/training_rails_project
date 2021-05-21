class Answer < ApplicationRecord
  belongs_to :questions,  optional: true
  before_save :downcase_fields

  def downcase_fields
      self.content.downcase!
  end

  scope :is_correct, ->{where correct: true}
  scope :by_user_answer, ->user_answer{ where id: user_answer.answers_id}
end
