class CreateExperts < ActiveRecord::Migration
  def change
    create_table :experts do |t|
      t.string :account, limit: 32, null: false
      t.string :hashed_password, limit: 100, null: false
      t.string :name, limit: 100, null: false
      t.boolean :primary, null: false
      t.timestamps null: false
    end
  end
end
