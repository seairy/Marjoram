class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :user, null: false
      t.string :name, limit: 200
      t.string :file, limit: 100, null: false
      t.timestamps null: false
    end
  end
end
