class UserAnswer < ApplicationRecord
  belongs_to :users
  belongs_to :exam_questions
end
