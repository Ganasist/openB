class AddImageToUploads < ActiveRecord::Migration
  def change
    add_attachment :uploads, :image
  end
end
