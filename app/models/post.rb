class Post < ActiveRecord::Base
  attr_accessor :published_at_date
  attr_accessor :published_at_time
  scope :visible, -> { where(visible: true) }
  scope :featured, -> { where(featured: true) }
  scope :latest, -> { order(published_at: :desc) }
end
