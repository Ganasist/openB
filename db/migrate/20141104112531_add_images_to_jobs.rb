class AddImagesToJobs < ActiveRecord::Migration
  def change
  	add_attachment :jobs, :image_before
  	add_attachment :jobs, :image_after
  	add_column :jobs, :image_before_processing, :boolean
  	add_column :jobs, :image_after_processing, :boolean
  end
end
