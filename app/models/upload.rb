class Upload < ActiveRecord::Base

	belongs_to :uploadable, polymorphic: true

  has_attached_file :image, styles: { thumb: '100x100>',
																  	 medium: '300x300>',
  																 original: '800x800>' }

  validates_attachment :image, size: { in: 0..3.megabytes, 
  																message: 'Picture must be less than 3 megabytes' }
  validates_attachment_content_type :image, content_type: /^image\/(png|gif|jpeg|jpg)/,
		                                     				 message: 'only (png/gif/jpeg) images'

	process_in_background :image, processing_image_url: 'ajax-loader.gif'

	def status
		if self.before?
			'before'
		elsif self.after?
			'after'
		else
			''
		end				
	end
end