class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.date :init
      t.date :finish
      t.string :notas

      t.timestamps
    end
  end
end
