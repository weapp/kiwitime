class AddDayToSittings < ActiveRecord::Migration
  def change
    add_column :sittings, :day, :date
    add_column :sittings, :start, :time
    add_column :sittings, :end, :time
  end
end
