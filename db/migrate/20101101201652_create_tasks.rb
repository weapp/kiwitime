class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.integer :time_forecast
      t.integer :project_id
      t.boolean :finished

      t.timestamps
    end
  end
end
