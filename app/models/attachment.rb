class Attachment < ActiveRecord::Base
  belongs_to :user
  mount_uploader :file, BaseUploader
  validates :name, presence: true
  validates :file, presence: true
end
