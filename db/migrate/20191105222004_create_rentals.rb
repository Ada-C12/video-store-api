class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.belongs_to :customer
      t.belongs_to :movie
      t.timestamps
    end
  end
end
