class RemoveStartAndEndFromSittings < ActiveRecord::Migration
  def up
    remove_column :sittings, :start
    remove_column :sittings, :end
  end

  def down
    add_column :sittings, :end, :datetime
    add_column :sittings, :start, :datetime
  end
end
