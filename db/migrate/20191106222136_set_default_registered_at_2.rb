class SetDefaultRegisteredAt2 < ActiveRecord::Migration[5.2]
  def change
    add_column(:customers, :registered_at3, :datetime, default: -> { 'CURRENT_TIMESTAMP' } )
  end
end
