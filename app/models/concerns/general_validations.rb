# Included in User, Contractor, Jobs
module GeneralValidations
	extend ActiveSupport::Concern
	included do

		before_validation :remove_blank_categories
		validates :categories, presence: true, length: { maximum: 4, message: 'Pick between 1-4 categories' }

		geocoded_by :full_address
		after_validation :geocode, if: ->(obj){ obj.full_address.present? && (obj.address_changed? ||
																																					obj.zip_code_changed? ||
																																					obj.city_changed? ||
																																					obj.state_changed?) }
		
		phony_normalize :phone, default_country_code: 'US'
		validates :phone, phony_plausible: true

		validates :name, presence: true, if: Proc.new { |m| !m.new_record? && !m.is_a?(Job) }

		validates :phone, 
	            :address, 
	            :city, 
	            :state, 
	            :company_name, 
	            :bio, presence: true, if: Proc.new { |m| !m.new_record? && m.is_a?(Contractor) }

		validates :zip_code, presence: true,
										 numericality: true,
									postcode_format: { country_code: :us,
																					message: 'Not a valid postcode for the US.'},
											allow_blank: false, if: Proc.new { |m| !m.new_record? || m.is_a?(Job) }
  end

  def remove_blank_categories
    self.categories.reject!(&:empty?)
  end

  def full_address
    "#{ self.try(:address) }, #{ self.try(:city) }, #{ self.try(:zip_code) }, #{ self.try(:state) }"
  end
end