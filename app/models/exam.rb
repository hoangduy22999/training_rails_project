class Exam < ApplicationRecord
  belongs_to :user
  has_many :exam_questions, dependent: :destroy
  has_many :questions, through: :exam_questions
  validates :user_id, presence: true
  has_many :results,dependent: :destroy

  before_save :set_subject_id

  attribute :result_average, :integer, default: 0
  attribute :subject_id, :integer, default: 1 

  def result_average
    result_count = self.results.count > 0 ? self.results.count : 1
    self.result_average = self.results.sum(:value) / result_count
  end

  def time_average
    result_count = self.results.count > 0 ? self.results.count : 1
    self.result_average = self.results.sum(:time) / result_count
  end

  def get_results
    Result.where(exam_id: self.id).count
  end

  def get_subject_name
    Subject.find(self.subject_id).name
  end

  def set_subject_id
    questions.select(:subject_id).distinct.count == 1 ? questions.first.subject_id : 1
  end

  def get_exam_question_id(question)
    self.exam_questions.where(question_id: question.id).first.id
  end

  scope :search_by_name, ->search{ where("name LIKE ?", "%#{search}%") }
  scope :search_by_time, ->time{ where("time = ?", time) }
  scope :search_by_subject, ->id{ where subject_id: id }
  scope :search_by_questions, ->questions{ joins(:questions).group("exams.id").having("COUNT(questions.id) = ?", questions)}
end
