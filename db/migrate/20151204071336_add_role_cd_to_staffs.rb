class AddRoleCdToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :role_cd, :string, limit: 20, null: false, after: :hashed_password
  end
end
