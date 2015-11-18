class AddChargingTypeCdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :charging_type_cd, :string, limit: 20, after: :type_cd
  end
end
