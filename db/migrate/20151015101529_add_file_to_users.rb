class AddFileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :file, :string, limit: 100, after: :outline
  end
end
