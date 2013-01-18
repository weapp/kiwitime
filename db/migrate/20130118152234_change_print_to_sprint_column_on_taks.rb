class ChangePrintToSprintColumnOnTaks < ActiveRecord::Migration
  def change
  	rename_column :tasks, :print_id, :sprint_id
  end
end
