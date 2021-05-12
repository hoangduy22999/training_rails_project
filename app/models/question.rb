class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :examquestions
  has_many :exams, through: :examquestions

  validates :content, presence: true
end
