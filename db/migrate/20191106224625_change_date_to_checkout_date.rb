class ChangeDateToCheckoutDate < ActiveRecord::Migration[5.2]
  def change
    rename_column :rentals, :date, :checkout_date
    add_column :rentals, :checkin_date, :date
  end
end
