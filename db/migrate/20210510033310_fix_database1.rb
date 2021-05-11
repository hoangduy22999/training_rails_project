class FixDatabase1 < ActiveRecord::Migration[6.1]
  def change
    remove_column :exams, :subject_id
  end
end
