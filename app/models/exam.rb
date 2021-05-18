class Exam < ApplicationRecord
  belongs_to :user
  has_many :exam_questions, dependent: :destroy
  has_many :questions, through: :exam_questions
  validates :user_id, presence: true
  belongs_to :subject
end
