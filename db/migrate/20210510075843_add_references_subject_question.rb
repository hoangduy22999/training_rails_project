class AddReferencesSubjectQuestion < ActiveRecord::Migration[6.1]
  def change
    change_table :questions do |t|
      t.references :subjects, column: :subject_id
    end 
  end
end
