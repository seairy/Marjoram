class Post < ActiveRecord::Base
  scope :visible, -> { where(visible: true) }
  scope :featured, -> { where(featured: true) }
  scope :latest, -> { order(published_at: :desc) }
end
