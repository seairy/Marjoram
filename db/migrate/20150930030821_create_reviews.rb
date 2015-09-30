class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user, null: false
      t.references :expert, null: false
      t.string :result_cd, limit: 20, null: false
      t.text :comment
      t.datetime :operated_at
      t.timestamps null: false
    end
  end
end
