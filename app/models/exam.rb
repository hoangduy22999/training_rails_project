class Exam < ApplicationRecord
  belongs_to :user
  has_many :examquestions
  has_many :questions, through: :examquestions
  validates :user_id, presence: true
end
