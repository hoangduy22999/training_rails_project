class FixSomething < ActiveRecord::Migration[6.1]
  def change
    change_table :exams do |t|
      t.remove :question_id
      t.references :subjects, column: :subject_id
    end
  end
end
