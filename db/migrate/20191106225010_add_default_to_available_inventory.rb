class AddDefaultToAvailableInventory < ActiveRecord::Migration[5.2]
  def change
    remove_column :movies, :available_inventory
    add_column :movies, :available_inventory, :integer, :default => :inventory
  end
end
