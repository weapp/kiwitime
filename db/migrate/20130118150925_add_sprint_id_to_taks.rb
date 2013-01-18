class AddSprintIdToTaks < ActiveRecord::Migration
  def change
    add_column :tasks, :print_id, :integer
  end
end
