class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :expert
  scope :unhandled, -> { where('score IS NULL') }
  scope :handled, -> { where('score IS NOT NULL') }

  def human_result
    if self.score.blank?
      '未评审'
    else
      "#{self.score}分"
    end
  end
end
