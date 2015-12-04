class User < ActiveRecord::Base
  include AASM
  attr_accessor :password, :password_confirmation
  before_create :hash_password
  mount_uploader :file, BaseUploader
  as_enum :type, [:regular, :visitor], prefix: true, map: :string
  as_enum :charging_type, [:free, :fee], prefix: true, map: :string
  belongs_to :country
  has_many :reviews
  has_many :ratings
  has_many :attachments
  has_many :bookings
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

  def group_a_review
    self.reviews.select{|r| r.expert.primary?}.first
  end

  def group_b_review
    self.reviews.select{|r| !r.expert.primary?}.first
  end

  def group_a_rating
    self.ratings.select{|r| r.expert.primary?}.first
  end

  def group_b_rating
    self.ratings.select{|r| !r.expert.primary?}.first
  end

  def general_score
    if self.ratings.count.zero?
      '未指派'
    elsif self.ratings.count == 1
      self.ratings.first.score.blank? ? '未评审' : "#{self.ratings.first.score}分"
    elsif self.ratings.count == 2
      if self.ratings.first.score.blank? and self.ratings.second.score.blank?
        '未评审'
      elsif !self.ratings.first.score.blank? and self.ratings.second.score.blank?
        "#{self.ratings.first.score}分"
      elsif self.ratings.first.score.blank? and !self.ratings.second.score.blank?
        "#{self.ratings.second.score}分"
      else
        "#{((self.ratings.first.score + self.ratings.second.score) / 2).round}分"
      end
    end
  end

  def authenticate password
    self.hashed_password == Digest::MD5.hexdigest(password) ? self : nil
  end

  def update_password password
    self.update(hashed_password: Digest::MD5.hexdigest(password))
  end

  def human_type
    case self.type
    when :regular then '论文代表'
    when :visitor then '旁听代表'
    end
  end

  def human_state
    case self.state
    when 'registered' then '待评审'
    when 'accepted' then '已通过'
    when 'declined' then '未通过'
    when 'trashed' then '已删除'
    end
  end

  protected
    def hash_password
      self.hashed_password = Digest::MD5.hexdigest self.password
    end
end
