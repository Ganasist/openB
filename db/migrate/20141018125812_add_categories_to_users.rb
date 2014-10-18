class AddCategoriesToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :categories, :string, array: true, default: []
  	
  	add_index  :users, :categories, using: 'gin'
  	add_index  :posts, :categories, using: 'gin'
  	add_index  :contractors, :categories, using: 'gin'
  end
end
