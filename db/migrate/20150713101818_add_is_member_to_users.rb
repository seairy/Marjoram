class AddIsMemberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_member, :boolean, null: false, after: :position
  end
end
