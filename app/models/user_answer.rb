class UserAnswer < ApplicationRecord
  belongs_to :result, optional: true
end
