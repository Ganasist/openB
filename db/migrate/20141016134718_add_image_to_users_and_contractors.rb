class AddImageToUsersAndContractors < ActiveRecord::Migration
  def change
    add_attachment :users, :image
    add_attachment :contractors, :image
    add_attachment :jobs, :image
    add_column :users, :image_processing, :boolean
    add_column :contractors, :image_processing, :boolean
    add_column :jobs, :image_processing, :boolean
  end
end