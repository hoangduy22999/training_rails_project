class Result < ApplicationRecord
  belongs_to :exam, optional: true
  belongs_to :user, optional: true
  has_many :user_answers, dependent: :destroy

  scope :my_results, ->user{ where(user_id: user.id) }
  scope :top, ->{ order(:value, :desc).last(5).reverse }
  scope :top_user, ->{ order(:value, :desc).group(:user_id).reverse }

  accepts_nested_attributes_for :user_answers, allow_destroy: true

  def get_subject_name
    Subject.find(self.subject_id).name
  end

  def get_user_name
    user&.name || "Deleted"
  end

  def get_exam_name
    exam&.name || "Deleted"
  end

  def get_user_answer_content(answer)
    self.user_answers.by_answer(answer).first.content
  end
  
  def get_user_answer_correct(answer)
    self.user_answers.by_answer(answer).first.correct
  end
  
  def is_correct_write(question)
    self.get_user_answer_content(question.answers.first).eql? question.get_answer_write
  end

end
