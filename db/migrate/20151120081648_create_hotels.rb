class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name, limit: 100, null: false
      t.string :address, limit: 500, null: false
      t.string :distance, limit: 50, null: false
      t.boolean :ferry_car, null: false
      t.timestamps null: false
    end
  end
end
