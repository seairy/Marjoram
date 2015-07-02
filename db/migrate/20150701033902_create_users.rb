class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :account, limit: 32, null: false
      t.string :hashed_password, limit: 100, null: false
      t.string :chinese_name, limit: 100, null: false
      t.string :foreign_name, limit: 100
      t.string :gender, limit: 10, null: false
      t.references :country, null: false
      t.string :address, limit: 500
      t.string :postal_code, limit: 20
      t.string :phone_number, limit: 50
      t.string :mobile_number, limit: 50
      t.string :fax_number, limit: 50
      t.string :email, limit: 200
      t.string :organization, limit: 200
      t.string :professional_title, limit: 100
      t.string :position, limit: 100
      t.text :remarks
      t.string :state, limit: 20, null: false
      t.datetime :last_signined_at, :current_signined_at
      t.timestamps null: false
    end
  end
end
