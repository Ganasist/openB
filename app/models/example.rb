class Example < ActiveRecord::Base

  belongs_to :contractor

  DURATION_UNITS = ['hours', 'days', 'weeks', 'months']

	attr_accessor :delete_image_before
  attr_reader :image_before_remote_url  
  
  before_validation { image_before.clear if delete_image_before == '1' }
  
  has_attached_file :image_before, styles: { thumb: '100x100>',
      																  	  medium: '300x300>',
        																  original: '800x800>' },
                											 default_url: 'jobs-default-:style.png'                 
  
  validates_attachment :image_before, size: { in: 0..3.megabytes, 
  																			 message: 'Picture must be less than 3 megabytes' }
  
  validates_attachment_content_type :image_before, content_type: /^image\/(png|gif|jpeg|jpg)/,
		                                     				 message: 'only (png/gif/jpeg) image_befores'

	# process_in_background :image_before, processing_image_url: 'ajax_spinner.gif'


	attr_accessor :delete_image_after
  attr_reader :image_after_remote_url  
  
  before_validation { image_after.clear if delete_image_after == '1' }
  
  has_attached_file :image_after, styles: { thumb: '100x100>',
      																  	 medium: '300x300>',
        																 original: '800x800>' },
              											  default_url: 'jobs-default-:style.png'                 
  
  validates_attachment :image_after, size: { in: 0..3.megabytes, 
  																			message: 'Picture must be less than 3 megabytes' }
  
  validates_attachment_content_type :image_after, content_type: /^image\/(png|gif|jpeg|jpg)/,
		                                     				 message: 'only (png/gif/jpeg) image_afters'

	process_in_background :image_after, processing_image_url: 'ajax_spinner.gif'
  

	def image_before_remote_url=(url_value)
     if url_value.present?
      self.image_before = URI.parse(url_value)
      @image_before_remote_url = url_value
    end
  end

  def image_after_remote_url=(url_value)
     if url_value.present?
      self.image_after = URI.parse(url_value)
      @image_after_remote_url = url_value
    end
  end

  before_validation :remove_blank_categories
  def remove_blank_categories
    self.categories.reject!(&:empty?)
  end

  def full_address
    "#{ self.contractor.try(:address) }, 
    #{ self.contractor.try(:city) }, 
    #{ self.contractor.try(:zip_code) }, 
    #{ self.contractor.try(:state) }"
  end
end
