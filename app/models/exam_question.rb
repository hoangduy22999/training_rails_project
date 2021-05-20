class ExamQuestion < ApplicationRecord
  belongs_to :question
  belongs_to :exam

  validates :exam_id, uniqueness: { scope: :question_id }
  scope :by_exam_id, ->exam_id{ where exam_id: exam_id }
  scope :by_question_id, ->question_id{ where question_id: question_id }
end
