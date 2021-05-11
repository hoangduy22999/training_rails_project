class FixDatabase < ActiveRecord::Migration[6.1]
  def change
    rename_table :sorces, :results

    change_column :results, :user_id, :integer, null: true
  end
end
