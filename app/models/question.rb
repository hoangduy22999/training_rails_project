class Question < ApplicationRecord
  has_many :answers
  has_many :exams_questions
  has_many :exams, through: :exams_questions
end
