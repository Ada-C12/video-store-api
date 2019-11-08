class UpdateInventoryMovies < ActiveRecord::Migration[5.2]
  def self.up
    Movie.update_all("available_inventory=inventory")
  end

  def self.down
  end
end
