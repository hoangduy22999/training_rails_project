class CreateAssingments < ActiveRecord::Migration[6.1]
  def change
    create_table :assingments do |t|
      t.references :exam, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true

      t.timestamps
    end
  end
end
