# Included in User, Contractor, Job
module Attachments
	extend ActiveSupport::Concern
	included do
		attr_accessor :delete_image
	  attr_reader :image_remote_url  
	  before_validation { image.clear if delete_image == '1' }
	  has_attached_file :image, styles: { thumb: '50x50>', original: '300x300>' }                   
	  validates_attachment :image, size: { :in => 0..2.megabytes, message: 'Picture must be less than 2 megabytes' }
	  validates_attachment_content_type :image,
	                                    :content_type => /^image\/(png|gif|jpeg|jpg)/,
	                                    :message => 'only (png/gif/jpeg) images', 
	                                    :processing_image_url => '/images/ajax_spinner.gif'
  
		process_in_background :image
  end
	  

	def image_remote_url=(url_value)
     if url_value.present?
      self.image = URI.parse(url_value)
      @image_remote_url = url_value
    end
  end
end