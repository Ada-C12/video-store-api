class DeleteExtraRegisteredColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column(:customers, :registered_at)
    remove_column(:customers, :registered_at2)
  end
end
