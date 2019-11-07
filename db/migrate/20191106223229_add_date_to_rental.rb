class AddDateToRental < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :date, :date
  end
end
