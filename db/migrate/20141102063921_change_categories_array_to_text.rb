class ChangeCategoriesArrayToText < ActiveRecord::Migration
  def self.up
  	change_column :contractors, :categories, :text, array: true, default: []
  	change_column :jobs, :categories, :text, array: true, default: []
  	change_column :users, :categories, :text, array: true, default: []
  end

  def self.down
  	change_column :contractors, :categories, :string, array: true, default: []
  	change_column :jobs, :categories, :string, array: true, default: []
  	change_column :users, :categories, :string, array: true, default: []
  end
end
