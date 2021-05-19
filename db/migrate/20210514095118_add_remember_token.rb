class AddRememberToken < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.string :remember_token
    end
  end
end
