class CreateExams < ActiveRecord::Migration[6.1]
  def change
    create_table :exams do |t|
      t.integer :question_id
      t.time :time
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
    add_index :exams, [:user_id, :created_at]
  end
end
