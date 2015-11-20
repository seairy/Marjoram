class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.references :user, null: false
      t.references :room, null: false
      t.date :entrance_date, :departure_date
      t.text :comment
      t.timestamps null: false
    end
  end
end
