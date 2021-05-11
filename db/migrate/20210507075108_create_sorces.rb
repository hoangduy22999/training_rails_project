class CreateSorces < ActiveRecord::Migration[6.1]
  def change
    create_table :sorces do |t|
      t.integer :value
      t.time :time
      t.references :subject, null: false, foreign_key: true
      t.references :exam, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
