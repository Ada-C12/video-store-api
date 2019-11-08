class AddColumnToRentals < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :checkout_date, :date, default: -> {'CURRENT_TIMESTAMP'}
  end
end
