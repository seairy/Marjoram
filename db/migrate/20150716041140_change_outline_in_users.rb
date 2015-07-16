class ChangeOutlineInUsers < ActiveRecord::Migration
  def change
    change_column :users, :outline, :text, limit: 65535
  end
end
