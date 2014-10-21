# Included in User, Contractor, Job
module Attachments
	extend ActiveSupport::Concern
	included do
		attr_accessor :delete_image
	  attr_reader :image_remote_url  
	  before_validation { image.clear if delete_image == '1' }
	  has_attached_file :image, styles: { thumb: '100x100>',
	  																 original: '300x300>' },
												 default_url: ':class-default-:style.png'                 
	  validates_attachment :image, size: { in: 0..3.megabytes, 
	  																message: 'Picture must be less than 3 megabytes' }
	  validates_attachment_content_type :image, content_type: /^image\/(png|gif|jpeg|jpg)/,
			                                     				 message: 'only (png/gif/jpeg) images'
  
		process_in_background :image, processing_image_url: 'ajax_spinner.gif'
  end
	  

	def image_remote_url=(url_value)
     if url_value.present?
      self.image = URI.parse(url_value)
      @image_remote_url = url_value
    end
  end
end