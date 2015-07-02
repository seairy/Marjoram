class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :user, null: false
      t.string :subject, limit: 500, null: false
      t.string :first_author, :second_author, limit: 100
      t.string :keywords, limit: 200
      t.text :outline
      t.string :state, limit: 20, null: false
      t.timestamps null: false
    end
  end
end
