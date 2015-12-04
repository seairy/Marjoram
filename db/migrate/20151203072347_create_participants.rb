class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :name, limit: 200, null: false
      t.string :gender_cd, limit: 20, null: false
      t.string :type_cd, limit: 20, null: false
      t.references :country, null: false
      t.string :phone_number, limit: 50
      t.string :mobile_number, limit: 50
      t.string :email, limit: 200
      t.string :organization_name, limit: 200
      t.string :subject, limit: 200
      t.boolean :is_member, null: false
      t.references :room
      t.string :room_number, limit: 20
      t.integer :registration_fees, null: false
      t.integer :isclt_member_fees, null: false
      t.boolean :checked_in, null: false
      t.datetime :checked_at
      t.references :staff
      t.timestamps null: false
    end
  end
end