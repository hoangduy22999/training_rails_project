class ExamQuestion < ApplicationRecord
  belongs_to :question, optional: true
  belongs_to :exam, optional: true
  has_many :user_answers, dependent: :destroy

  scope :by_exam, ->(exam) { where exam: exam }
  scope :by_question, ->(question) { where question: question }
  scope :by_user_answer, ->(user_answer) { where id: user_answer.exam_question_id }
end
