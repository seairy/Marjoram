class AddHotelInfoToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :entrance_date, :date, after: :room_number
    add_column :participants, :departure_date, :date, after: :entrance_date
  end
end