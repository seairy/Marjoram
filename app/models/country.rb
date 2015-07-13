class Country < ActiveRecord::Base
  scope :alphabetic, -> { order('CONVERT(countries.name USING GBK) ASC') }

  def name_with_initial
    "#{PinYin.abbr(self.name).upcase[0]} - #{self.name}"
  end
end
