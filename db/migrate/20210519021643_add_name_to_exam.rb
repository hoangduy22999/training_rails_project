class AddNameToExam < ActiveRecord::Migration[6.1]
  def change
    change_table :exams do |t|
      t.string :name
    end
    change_table :results do |t|
      t.change :time, :integer
    end
  end
end
