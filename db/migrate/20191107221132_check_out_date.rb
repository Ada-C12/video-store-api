class CheckOutDate < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :check_out_date, :datetime
  end
end
