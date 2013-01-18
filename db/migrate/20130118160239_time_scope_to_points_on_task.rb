class TimeScopeToPointsOnTask < ActiveRecord::Migration
  def up
    add_column :tasks, :points, :float
    remove_column :tasks, :time_scope
  end

  def down
	add_column :tasks, :time_scope, :integer
    remove_column :tasks, :points
  end
end


