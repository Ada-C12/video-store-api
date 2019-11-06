class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.date :checkout_date
      t.date :due_date
      t.timestamps
    end

    add_reference :rentals, :customer, foreign_key: true
    add_reference :rentals, :movie, foreign_key: true
  end
end
