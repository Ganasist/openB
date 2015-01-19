class AddAuthenticationTokenUsersContractors < ActiveRecord::Migration
  def change
    add_column :users, :authentication_token, :string
    add_column :contractors, :authentication_token, :string

    add_index :users, :authentication_token
    add_index :contractors, :authentication_token
  end
end
