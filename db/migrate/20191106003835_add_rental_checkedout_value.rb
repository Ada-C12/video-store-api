class AddRentalCheckedoutValue < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :movies_checked_out_count, :integer, default: 0
    add_column :movies, :available_inventory, :integer, default: :inventory 
  end
end
