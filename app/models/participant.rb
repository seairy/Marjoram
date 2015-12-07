class Participant < ActiveRecord::Base
  as_enum :type, [:councilman, :invited, :regular, :visitor], prefix: true, map: :string
  as_enum :gender, [:male, :female, :unknown], prefix: true, map: :string
  belongs_to :country
  belongs_to :room
  belongs_to :staff
  validates :name, presence: true
  validates :gender, presence: true
  validates :type, presence: true
  validates :registration_fees, presence: true, numericality: { only_integer: true }
  validates :isclt_member_fees, presence: true, numericality: { only_integer: true }

  def unchecked_in?
    !self.checked_in?
  end

  def human_type
    case self.type
    when :councilman then '理事代表'
    when :invited then '特邀代表'
    when :regular then '论文代表'
    when :visitor then '旁听代表'
    end
  end

  def human_gender
    case self.gender
    when :male then '男'
    when :female then '女'
    when :unknown then '未知'
    end
  end

  def human_check_in
    self.checked_in? ? "于 #{self.checked_at.strftime('%d日%H时%M分')} 报到" : '未报到'
  end

  def human_styled_check_in
    self.checked_in? ? "<span class=\"text-success\">于 #{self.checked_at.strftime('%d日%H时%M分')} 报到</span>" : '<span class="text-danger">未报到</span>'
  end
end