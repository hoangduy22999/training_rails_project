class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :exam_questions
  has_many :exams, through: :exam_questions

  validates :content, presence: true

end
