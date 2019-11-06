class DroppingJoinTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :customers_movies_joins
  end
end
