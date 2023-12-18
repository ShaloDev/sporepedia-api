class CreateCreatures < ActiveRecord::Migration[7.0]
  def change
    create_table :creatures do |t|
      t.integer :creature_id
      t.timestamps
    end
  end
end
