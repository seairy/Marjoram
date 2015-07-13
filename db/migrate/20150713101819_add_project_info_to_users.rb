class AddProjectInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subject, :string, limit: 500, after: :is_member
    add_column :users, :first_author, :string, limit: 200, after: :subject
    add_column :users, :second_author, :string, limit: 200, after: :first_author
    add_column :users, :keywords, :string, limit: 200, after: :second_author
    add_column :users, :outline, :text, limit: 200, after: :keywords
    add_column :users, :project_state, :string, limit: 20, after: :outline
  end
end
