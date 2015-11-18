class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :expert
  scope :unhandled, -> { where('score IS NULL') }
  scope :handled, -> { where('score IS NOT NULL') }
end
