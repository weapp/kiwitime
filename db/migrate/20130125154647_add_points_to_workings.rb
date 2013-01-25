class AddPointsToWorkings < ActiveRecord::Migration
  def change
    add_column :workings, :points, :float
  end
end
