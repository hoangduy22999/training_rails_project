class AddSujectIdToExam < ActiveRecord::Migration[6.1]
  def change
    change_table :exams do |t|
      t.integer :subject_id
    end
  end
end
