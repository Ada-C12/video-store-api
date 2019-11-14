class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.references :customer, index: true
      t.references :movie, index: true 

      t.timestamps
    end
  end
end
