class ChangeRegistedAtColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column(:customers, :registered_at3, :registered_at)
  end
end
