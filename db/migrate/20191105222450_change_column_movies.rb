class ChangeColumnMovies < ActiveRecord::Migration[5.2]
  def change
    change_column :movies, :release_date, 'date USING CAST(release_date AS date)'

  end
end
