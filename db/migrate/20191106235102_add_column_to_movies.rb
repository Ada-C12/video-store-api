class AddColumnToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :available_inventory, :integer, default: 0 
  end
end
