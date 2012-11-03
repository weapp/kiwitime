class AddPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :encrypted_password, :string
    add_column :users, :add_salt_to_users, :string
    add_column :users, :salt, :string
  end
end
