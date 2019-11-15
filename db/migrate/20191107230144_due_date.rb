class DueDate < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :check_in, :datetime
    add_column :rentals, :check_out, :datetime
    add_column :rentals, :due_date, :datetime
  end
end
