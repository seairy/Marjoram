class User < ActiveRecord::Base
  include AASM
  attr_accessor :password, :password_confirmation
  before_create :hash_password
  belongs_to :country
  has_many :reviews
  aasm column: 'state' do
    state :registered, initial: true
    state :accepted
    state :declined
    state :trashed
    event :trash do
      transitions to: :trashed
    end
  end
  scope :latest, -> { order(created_at: :desc) }
  validates :account, :format => { :with => /\A[a-zA-Z0-9_]+\z/, :message => "只能使用英文、数字及下划线" }, :length => { :in => 5..16 }, :uniqueness => true, :presence => true
  validates :password, :password_confirmation, :format => { :with => /\A[a-zA-Z0-9_]+\z/, :message => "只能使用英文、数字及下划线" }, :length => { :in => 6..16 }, :presence => true, confirmation: true, :on => :create
  validates :chinese_name, :length => { :maximum => 100 }, :presence => true
  validates :gender, presence: true
  validates :subject, presence: true
  validates :first_author, presence: true
  validates :keywords, presence: true
  validates :outline, presence: true

  def group_a_review
    self.reviews.select{|r| r.expert.primary?}.first
  end

  def group_b_review
    self.reviews.select{|r| !r.expert.primary?}.first
  end

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
