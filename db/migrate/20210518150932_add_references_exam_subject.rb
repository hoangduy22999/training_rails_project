class AddReferencesExamSubject < ActiveRecord::Migration[6.1]
  def change
    change_table :exams do |t|
    t.remove :subjects_id
    end 
  end
end
