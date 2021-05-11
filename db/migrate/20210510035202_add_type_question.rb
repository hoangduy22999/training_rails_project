class AddTypeQuestion < ActiveRecord::Migration[6.1]
  def change
    rename_table :quetion_types, :question_types
    change_table :questions do |t|
      t.references :question_types, column: :type_id
    end
  end
end
