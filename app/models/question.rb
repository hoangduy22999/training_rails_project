class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :exam_questions, dependent: :destroy
  has_many :exams, through: :exam_questions

  validates :content, presence: true

  scope :search_by_name, ->search{ where("content LIKE ?", "%#{search}%") }
  scope :group_by_exam, ->exam{ where(exam_id: exam.id) }
  scope :group_by_type, ->type_id{ where(type_id: type_id) }
  scope :group_by_subject, ->subject_id{ where(subject_id: subject_id)}

  accepts_nested_attributes_for :answers, allow_destroy: true

  def get_answer_write
    self.answers.first.content
  end

  def get_subject_name
    self.subject_id ? Subject.find(self.subject_id).name : "Customer"
  end

  def get_type
    self.type_id == 1 ? "Choice" : "Write"
  end
end
