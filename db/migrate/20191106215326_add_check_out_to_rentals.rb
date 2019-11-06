class AddCheckOutToRentals < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :check_out, :date
  end
end
