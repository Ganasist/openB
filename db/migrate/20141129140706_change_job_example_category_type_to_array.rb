class ChangeJobExampleCategoryTypeToArray < ActiveRecord::Migration
  def change
  	remove_column :jobs, :category, :text
  	remove_column :examples, :category, :text

  	add_column :jobs, :category, :text, array: true, default: []
  	add_column :examples, :category, :text, array: true, default: []
  	
  	add_index  :jobs, :category, using: 'gin'
  	add_index  :examples, :category, using: 'gin'
  end
end
