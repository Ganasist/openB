class RemoveImagesFromAllOtherModels < ActiveRecord::Migration
  def change
  	remove_attachment :contractors, :image
  	remove_column :contractors, :image_processing

  	remove_attachment :examples, :image_before
  	remove_column :examples, :image_before_processing

  	remove_attachment :examples, :image_after
  	remove_column :examples, :image_after_processing

  	remove_attachment :jobs, :image_before
  	remove_column :jobs, :image_before_processing

  	remove_attachment :jobs, :image_after
  	remove_column :jobs, :image_after_processing

  	remove_attachment :users, :image
  	remove_column :users, :image_processing

  	add_attachment :uploads, :image_before
  	add_attachment :uploads, :image_after
  	add_column :uploads, :image_before_processing, :boolean
  	add_column :uploads, :image_after_processing, :boolean
  end
end
