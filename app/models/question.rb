class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :exam_questions
  has_many :exams, through: :exam_questions

  validates :content, presence: true

  scope :search_by_name, ->search{ where("name LIKE ?", "%#{search}%") }
  scope :group_by_exam, ->exam{ where(exam_id: exam.id) }

end
