class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :school_id
      t.string :gender
      t.integer :age
      t.string :password_digest

      t.timestamps
    end
  end
end
