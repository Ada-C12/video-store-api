class AddDefaultsToNewRental < ActiveRecord::Migration[5.2]
  def change
    change_column :rentals, :checkout_date, :date, default: Time.now
    change_column :rentals, :due_date, :date, default: (Time.now + 604800)
  end
end
