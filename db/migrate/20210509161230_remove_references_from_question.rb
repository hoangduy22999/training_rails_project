class RemoveReferencesFromQuestion < ActiveRecord::Migration[6.1]
  def change
    change_table :questions do |t|
      t.remove :answer_id
    end
  end
end
