class Dropreferences < ActiveRecord::Migration[6.1]
  def up
    change_table :questions do |f|
      f.remove :exam_id
    end
  end
end
