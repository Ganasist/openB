class AddStateToUsersAndContractors < ActiveRecord::Migration
  def change
    add_column :contractors, :state, :string
    add_column :users, :state, :string
  end
end
