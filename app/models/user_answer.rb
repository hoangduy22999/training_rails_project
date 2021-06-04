class UserAnswer < ApplicationRecord
  belongs_to :result, optional: true
  belongs_to :exam_question, optional: true
  belongs_to :answer, optional: true

  scope :is_correct, ->{where correct: true}
  scope :by_exam_question, ->exam_question_id{where exam_question_id: exam_question_id}
  scope :by_answer, ->answer{ where answer_id: answer.id }
end
