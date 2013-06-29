class RemoveFieldRememberTokenFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :remember_token
  end
end
