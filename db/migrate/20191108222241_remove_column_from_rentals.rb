class RemoveColumnFromRentals < ActiveRecord::Migration[5.2]
  def change
    remove_column :rentals, :checkout_date
  end
end
