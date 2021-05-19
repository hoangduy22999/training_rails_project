class Result < ApplicationRecord
  belongs_to :exam
  belongs_to :user

  scope :my_results, ->user{ where(user_id: user.id) }
  scope :top, ->{ order(:value, :desc).first(5)}
end
