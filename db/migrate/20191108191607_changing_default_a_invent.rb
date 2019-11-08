class ChangingDefaultAInvent < ActiveRecord::Migration[5.2]
  def change
    Movie.update_all("available_inventory=inventory")
  end
end
