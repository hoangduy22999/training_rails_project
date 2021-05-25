class UserAnswer < ApplicationRecord
  belongs_to :result, optional: true
  belongs_to :exam_question, optional: true

  scope :is_correct, ->{where correct: true}
  scope :by_exam_question, ->exam_question_id{where exam_question_id: exam_question_id}
  scope :by_answer, ->answer{ where answers_id: answer.id }
end
