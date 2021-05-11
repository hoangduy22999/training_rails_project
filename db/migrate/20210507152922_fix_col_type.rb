class FixColType < ActiveRecord::Migration[6.1]
  def up
    change_table :exams do |f|
      f.change :time, :integer
    end
  end

  def down
  end
end
