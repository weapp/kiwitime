class AddIndexToTasks < ActiveRecord::Migration
  def change
    add_index :projects, :project_id
    add_index :sittings, :user_id
    add_index :sittings, :task_id
  end
end
