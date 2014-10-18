class AddCategoriesToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :categories, :string, array: true, default: []
  	add_column :jobs, :categories, :string, array: true, default: []
  	
  	add_index  :users, :categories, using: 'gin'
  	add_index  :jobs, :categories, using: 'gin'
  	add_index  :contractors, :categories, using: 'gin'
  end
end
