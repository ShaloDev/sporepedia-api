class AddFieldsToCreatures < ActiveRecord::Migration[7.0]
  def change
    add_column :creatures, :image, :string
    add_column :creatures, :name, :string
    add_column :creatures, :author, :string
    add_column :creatures, :description, :text
  end
end
