class Exam < ApplicationRecord
  belongs_to :user
  has_many :exams_questions
  has_many :questions, through: :exams_questions
  validates :user_id, presence: true
end
