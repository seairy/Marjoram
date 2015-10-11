class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :expert
  as_enum :result, [:progressing, :success, :failure, :reservation], prefix: true, map: :string
  scope :unhandled, -> { where(result_cd: :progressing) }
  scope :handled, -> { where.not(result_cd: :progressing) }

  def human_result
    case self.result
    when :progressing then '未评审'
    when :success then '通过'
    when :failure then '不通过'
    when :reservation then '保留'
    end
  end
end
