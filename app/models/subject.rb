class Subject < ApplicationRecord
    before_save :downcase_fields

    def downcase_fields
        self.name.downcase!
    end

end
