class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :expert
  as_enum :result, [:progressing, :success, :failure, :reservation], prefix: true, map: :string
  scope :unhandled, -> { where(result_cd: :progressing) }
  scope :handled, -> { where.not(result_cd: :progressing) }
end
