class Answer < ApplicationRecord
  belongs_to :questions,  optional: true
end
