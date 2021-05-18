class Subject < ApplicationRecord
    before_save :downcase_fields
    has_many :exams

    def downcase_fields
        self.name.downcase!
    end
end
