class RemovePasswordFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :password
    remove_column :users, :password_confirmation
  end
end
