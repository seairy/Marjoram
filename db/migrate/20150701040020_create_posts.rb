class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, limit: 200, null: false
      t.text :content
      t.boolean :visible, null: false
      t.boolean :featured, null: false
      t.datetime :published_at, null: false
      t.timestamps null: false
    end
  end
end
