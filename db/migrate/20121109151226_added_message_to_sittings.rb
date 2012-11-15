class AddedMessageToSittings < ActiveRecord::Migration
  def change
        add_column :sittings, :message, :string
  end
end
