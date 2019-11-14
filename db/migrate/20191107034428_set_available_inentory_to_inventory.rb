class SetAvailableInentoryToInventory < ActiveRecord::Migration[5.2]
  def self.up
    Movie.update_all("available_inventory=inventory")
  end
end