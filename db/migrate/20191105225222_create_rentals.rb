class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.date :due_date
      t.string :status
      t.timestamps
    end
  end
end
