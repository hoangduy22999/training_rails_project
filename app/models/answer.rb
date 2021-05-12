class Answer < ApplicationRecord
  belongs_to :questions,  optional: true

  validates :content, presence: true
end
