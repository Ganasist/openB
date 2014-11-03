class Example < ActiveRecord::Base


	attr_accessor :delete_before_image
  attr_reader :before_image_remote_url  
  
  before_validation { before_image.clear if delete_before_image == '1' }
  
  has_attached_file :before_image, styles: { thumb: '100x100>',
																  	 medium: '300x300>',
  																 original: '800x800>' },
											 default_url: ':class-default-:style.png'                 
  
  validates_attachment :before_image, size: { in: 0..3.megabytes, 
  																			 message: 'Picture must be less than 3 megabytes' }
  
  validates_attachment_content_type :before_image, content_type: /^before_image\/(png|gif|jpeg|jpg)/,
		                                     				 message: 'only (png/gif/jpeg) before_images'

	process_in_background :before_image, processing_image_url: 'ajax_spinner.gif'


	attr_accessor :delete_after_image
  attr_reader :after_image_remote_url  
  
  before_validation { after_image.clear if delete_after_image == '1' }
  
  has_attached_file :after_image, styles: { thumb: '100x100>',
																  	 medium: '300x300>',
  																 original: '800x800>' },
											 default_url: ':class-default-:style.png'                 
  
  validates_attachment :after_image, size: { in: 0..3.megabytes, 
  																			message: 'Picture must be less than 3 megabytes' }
  
  validates_attachment_content_type :after_image, content_type: /^after_image\/(png|gif|jpeg|jpg)/,
		                                     				 message: 'only (png/gif/jpeg) after_images'

	process_in_background :after_image, processing_image_url: 'ajax_spinner.gif'
  

	def before_image_remote_url=(url_value)
     if url_value.present?
      self.before_image = URI.parse(url_value)
      @before_image_remote_url = url_value
    end
  end

  def after_image_remote_url=(url_value)
     if url_value.present?
      self.after_image = URI.parse(url_value)
      @after_image_remote_url = url_value
    end
  end

end
