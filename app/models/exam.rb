class Exam < ApplicationRecord
  belongs_to :user
  has_many :exam_questions
  has_many :questions, through: :exam_questions
  validates :user_id, presence: true
end
