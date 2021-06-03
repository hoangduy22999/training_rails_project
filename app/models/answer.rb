class Answer < ApplicationRecord
  belongs_to :questions, optional: true

  scope :is_correct, ->{where correct: true}
  scope :is_not_correct, ->{where correct: false}
  scope :by_user_answer, ->user_answer{ where id: user_answer.answers_id}
end
