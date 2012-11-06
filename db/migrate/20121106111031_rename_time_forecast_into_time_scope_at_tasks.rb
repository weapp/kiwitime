class RenameTimeForecastIntoTimeScopeAtTasks < ActiveRecord::Migration
  def change
    rename_column :tasks, :time_forecast, :time_scope
  end
end
