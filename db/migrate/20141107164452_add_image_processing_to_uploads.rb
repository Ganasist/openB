class AddImageProcessingToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :image_processing, :boolean
  end
end
