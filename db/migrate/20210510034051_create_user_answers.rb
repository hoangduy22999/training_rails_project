class CreateUserAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :user_answers do |t|
      t.references :users, null: false, foreign_key: true
      t.references :exam_questions, null: false, foreign_key: true

      t.timestamps
    end
  end
end
