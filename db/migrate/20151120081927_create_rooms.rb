class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.references :hotel, null: false
      t.string :name, limit: 50, null: false
      t.decimal :price, precision: 7, scale: 2, null: false
      t.integer :quantity, limit: 2, null: false
      t.timestamps null: false
    end
  end
end
