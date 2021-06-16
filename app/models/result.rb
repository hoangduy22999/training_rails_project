class Result < ApplicationRecord
  belongs_to :exam, optional: true
  belongs_to :user, optional: true
  has_many :user_answers, dependent: :destroy

  scope :my_results, ->(user) { where(user_id: user.id) }
  scope :top, -> { order(value: :desc, time: :asc) }
  scope :top_user, -> { order(value: :desc, time: :asc).group(:user_id) }

  accepts_nested_attributes_for :user_answers, allow_destroy: true

  def subject_name
    Subject.find(subject_id).name
  end

  def user_name
    user&.name || 'Deleted'
  end

  def exam_name
    exam&.name || 'Deleted'
  end

  def user_answer_content(answer)
    user_answers.by_answer(answer).first.content
  end

  def user_answer_correct(answer)
    user_answers.by_answer(answer).first.correct
  end

  def correct_write?(question)
    user_answer_content(question.answers.first).eql? question.answer_write
  end
end
