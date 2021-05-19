class RemovePasswordDigest < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.remove :password_digest
    end
  end
end
