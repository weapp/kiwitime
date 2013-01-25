class CreateWorkings < ActiveRecord::Migration
  def change
    create_table :workings do |t|
      t.integer :sprint_id
      t.date :day

      t.timestamps
    end
  end
end
