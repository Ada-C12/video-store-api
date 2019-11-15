class AddOverdueToRental < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :is_overdue, :boolean, default: false 
  end
end
