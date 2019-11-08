class AddAnotherColumnToRentals < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :checkout_date, :datetime, default: -> {'CURRENT_TIMESTAMP'}
  end
end
