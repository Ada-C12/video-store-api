class RemoveCustomerFromMovies < ActiveRecord::Migration[5.2]
  def change
    remove_reference(:movies, :customer, index: true, foreign_key: true)
  end
end
