class RenameAssignmeToExamQuestions < ActiveRecord::Migration[6.1]
  def change
    rename_table :assingments, :exam_questions
  end
end
