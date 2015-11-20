class Room < ActiveRecord::Base
  belongs_to :hotel
  has_many :bookings

  def full?
    self.bookings.count >= self.quantity
  end
end
