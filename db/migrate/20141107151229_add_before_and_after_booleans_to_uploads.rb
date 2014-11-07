class AddBeforeAndAfterBooleansToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :before, :boolean, default: false
    add_column :uploads, :after, :boolean, default: false

    remove_attachment :uploads, :image_before
    remove_attachment :uploads, :image_after

    remove_column :uploads, :image_before_processing, :boolean
    remove_column :uploads, :image_after_processing, :boolean
  end
end
