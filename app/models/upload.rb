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

	attr_accessor :delete_image
	attr_reader :image_remote_url
	before_validation { image.clear if delete_image == '1' }

	def image_remote_url=(url_value)
		if url_value.present?
			self.image = URI.parse(url_value)
			@image_remote_url = url_value
		end
	end

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
