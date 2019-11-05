class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.references :customer, foreign_key: true
      t.references :movie, foreign_key: true
      
      t.timestamps
    end
  end
end
