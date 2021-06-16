class Answer < ApplicationRecord
  belongs_to :question
  has_many :user_answers, dependent: :nullify

  scope :is_correct, -> { where correct: true }
  scope :is_not_correct, -> { where correct: false }
  scope :by_user_answer, -> user_answer { where id: user_answer.answers_id }

  def percent_point
    total_answers = question.answers
    answer_corrects = total_answers.is_correct.count
    answer_not_corrects = total_answers.is_not_correct.count
    correct ? (100 / answer_corrects) : (-100 / answer_not_corrects)
  end
end
