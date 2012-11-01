class CreateSittings < ActiveRecord::Migration
  def change
    create_table :sittings do |t|
      t.integer :user_id
      t.integer :task_id
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
