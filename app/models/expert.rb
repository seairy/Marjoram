class Expert < ActiveRecord::Base
  attr_accessor :password, :password_confirmation
  before_create :hash_password
  has_many :reviews
  has_many :ratings
  scope :group_a, -> { where(primary: true) }
  scope :group_b, -> { where(primary: false) }

  def authenticate password
    self.hashed_password == Digest::MD5.hexdigest(password) ? self : nil
  end

  def update_password password
    self.update(hashed_password: Digest::MD5.hexdigest(password))
  end

  protected
    def hash_password
      self.hashed_password = Digest::MD5.hexdigest self.password
    end
end