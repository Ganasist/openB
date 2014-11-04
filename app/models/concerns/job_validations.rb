# Included in User, Contractor
module JobValidations
	extend ActiveSupport::Concern
	included do

		before_validation :remove_blank_categories

		scope :relevant_categories, -> (categories){ where('categories && ARRAY[?]', categories) }

		validates :categories, presence: true, 
														 length: { minimum: 1,
														 					 maximum: 4, 
														 		   		 message: 'Pick between 1-4 categories' }

		
		# phony_normalize :phone, default_country_code: 'US'
		# validates :phone, phony_plausible: true

		validates :title, presence: true, 
	                 allow_blank: false, 
	                      length: { in: 5..50 }

    validates :description, presence: true, 
	                       allow_blank: false, 
	                            length: { in: 10..2000 }

		# validates :phone, 
	 #            :address, 
	 #            :city, 
	 #            :state, 
	 #            :company_name, 
	 #            :bio, presence: true, if: Proc.new { |m| !m.new_record? && m.is_a?(Contractor) }

		# validates :zip_code, presence: true, 
		# 								 numericality: true,
		# 							postcode_format: { country_code: :us,
		# 																			message: 'Not a valid postcode for the US.'},
		# 																			     if: Proc.new { |o| !o.new_record? || o.is_a?(Job) }
  end

  def remove_blank_categories
    self.categories.reject!(&:empty?)
  end
end