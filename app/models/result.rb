class Result < ApplicationRecord
  belongs_to :exam
  belongs_to :user
  has_many :user_answers, dependent: :destroy

  scope :my_results, ->user{ where(user_id: user.id) }
  scope :top, ->{ order(:value, :desc).first(5)}

  accepts_nested_attributes_for :user_answers, allow_destroy: true
end
