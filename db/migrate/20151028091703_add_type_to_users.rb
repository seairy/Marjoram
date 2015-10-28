class AddTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :type_cd, :string, limit: 20, null: false, default: 'regular', after: :hashed_password
  end
end
