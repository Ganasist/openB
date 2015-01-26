class AddAttachmentPdfToBids < ActiveRecord::Migration
  def self.up
    change_table :bids do |t|
      t.attachment :pdf
    end
  end

  def self.down
    remove_attachment :bids, :pdf
  end
end
