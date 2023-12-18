class AddCreatedTimeToCreature < ActiveRecord::Migration[7.0]
  def change
    add_column :creatures, :created, :string
  end
end
