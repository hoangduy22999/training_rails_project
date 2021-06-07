class ExamQuestion < ApplicationRecord
  belongs_to :question, optional: true
  belongs_to :exam, optional: true
  has_many :user_answers, dependent: :destroy

  scope :by_exam_id, ->exam_id{ where exam_id: exam_id }
  scope :by_question_id, ->question_id{ where question_id: question_id }
  scope :by_user_answer, ->user_answer{ where id: user_answer.exam_question_id}
end
