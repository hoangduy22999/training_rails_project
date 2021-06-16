class Exam < ApplicationRecord
  belongs_to :user, optional: true
  has_many :exam_questions, dependent: :delete_all
  has_many :questions, through: :exam_questions
  has_many :results, dependent: :nullify

  before_save :set_subject

  attribute :result_average, :integer, default: 0

  validates :user_id, presence: true

  def result_average
    result_count = results.count > 0 ? results.count : 1
    results.sum(:value) / result_count
  end

  def time_average
    result_count = results.count > 0 ? results.count : 1
    results.sum(:time) / result_count
  end

  def point_per_question(max)
    total_questions = questions.count
    max / total_questions
  end

  def total_results
    results.count
  end

  def subject_name
    subject_id.nil? ? "Undefine" : Subject.find(subject_id).name
  end

  def set_subject
    subject_id = questions.group(:subject_id).count.length == 1 ? questions.first.subject_id : 1
  end

  def exam_question_id(question)
    exam_questions.where(question_id: question.id).first.id
  end

  scope :search_by_name, ->(search) { where("name LIKE ?", "%#{search}%") }
  scope :search_by_time, ->(time) { where("time = ?", time) }
  scope :search_by_subject, ->(id) { where subject_id: id }
  scope :search_by_questions, ->(questions) { joins(:questions).group("exams.id").having("COUNT(questions.id) = ?", questions) }
end
