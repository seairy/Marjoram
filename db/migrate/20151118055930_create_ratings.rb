class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user, null: false
      t.references :expert, null: false
      t.integer :score
      t.text :comment
      t.datetime :finished_at
      t.timestamps null: false
    end
  end
end
