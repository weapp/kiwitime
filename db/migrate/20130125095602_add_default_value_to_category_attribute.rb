class AddDefaultValueToCategoryAttribute < ActiveRecord::Migration
def up
    change_column :tasks, :category, :string, :default => "feature"
end

def down
    change_column :tasks, :category, :string, :default => nil
end
end
