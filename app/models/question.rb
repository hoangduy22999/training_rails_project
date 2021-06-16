class Question < ApplicationRecord
  has_many :answers, dependent: :delete_all
  has_many :exam_questions, dependent: :delete_all
  has_many :exams, through: :exam_questions

  validates :content, presence: true

  scope :search_by_name, ->search{ where("content LIKE ?", "%#{search}%") }
  scope :group_by_exam, ->exam{ where(exam_id: exam.id) }
  scope :group_by_type, ->type{ where(types: type) }
  scope :group_by_subject, ->subject_id{ where(subject_id: subject_id)}

  accepts_nested_attributes_for :answers, allow_destroy: true

  def answer_write
    answers.first.content
  end

  def subject_name
    subject_id ? Subject.find(subject_id).name : "Customer"
  end
end
