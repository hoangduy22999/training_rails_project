class RenameQuestionModel < ActiveRecord::Migration[6.1]
  def change
    rename_column :questions, :question_types_id, :type_id
    rename_column :questions, :subjects_id, :subject_id
  end
end
