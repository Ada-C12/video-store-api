class AddForeignKeysToRentals < ActiveRecord::Migration[5.2]
  def change
    add_reference :rentals, :customer
    add_reference :rentals, :movie
  end
end
