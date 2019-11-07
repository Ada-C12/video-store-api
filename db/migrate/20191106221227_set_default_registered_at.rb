class SetDefaultRegisteredAt < ActiveRecord::Migration[5.2]
  def change
    add_column(:customers, :registered_at2, :datetime, :default => Time.now )
  end
end
