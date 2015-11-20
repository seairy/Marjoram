class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :room
  validates :room_id, presence: true
  validates :entrance_date, presence: true
  validates :departure_date, presence: true
  validate :entrance_and_departure_date

  def entrance_and_departure_date
    errors.add(:entrance_date, '不能小于12月8日') if entrance_date.to_time < Time.local(2015, 12, 8)
    errors.add(:entrance_date, '不能大于12月10日') if entrance_date.to_time > Time.local(2015, 12, 10)
    errors.add(:departure_date, '不能小于12月8日') if departure_date.to_time < Time.local(2015, 12, 8)
    errors.add(:departure_date, '不能大于12月10日') if departure_date.to_time > Time.local(2015, 12, 10)
  end
end
