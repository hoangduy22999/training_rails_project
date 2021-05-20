class Exam < ApplicationRecord
  belongs_to :user
  has_many :exam_questions, dependent: :destroy
  has_many :questions, through: :exam_questions
  validates :user_id, presence: true
  has_many :results,dependent: :destroy

  attribute :result_average, :integer, default: 0
  attribute :subject_id, :integer, default: 1 

  def result_average
    self.result_average = self.results.sum(:value) / self.results.count 
  end

  def subject_id
    questions.select(:subject_id).distinct.count == 1 ? questions.first.subject_id : 1
  end

  scope :search_by_name, ->search{ where("name LIKE ?", "%#{search}%") }
  scope :search_lt_time, ->time{ where("time < ?", time) }
  scope :search_gt_time, ->time{ where("time > ?", time) }
  scope :search_by_subject, ->id{ where subject_id: id }
end
