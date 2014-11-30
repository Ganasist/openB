# Included in User, Contractor
module MemberValidations
	extend ActiveSupport::Concern
	included do

    scope :relevant_categories, -> (categories){ where('categories @> ARRAY[?]', categories) }
    scope :relevant_categories_count, -> (categories){ where('categories @> ARRAY[?]', categories).count }


		has_many :comments, as: :commenterable, dependent: :destroy

		validates :categories, presence: true, 
														 length: { minimum: 1,
														 					 maximum: 4, 
														 		   		 message: 'Pick between 1-4 categories' }, 
																 if: Proc.new { |o| !o.new_record? }

		geocoded_by :full_address
		after_validation :geocode, if: ->(obj){ obj.full_address.present? && (obj.address_changed? ||
																																					obj.zip_code_changed? ||
																																					obj.city_changed? ||
																																					obj.state_changed?) }
		
		phony_normalize :phone, default_country_code: 'US'
		validates :phone, phony_plausible: true

		validates :name, presence: true, if: Proc.new { |o| !o.new_record? }

		validates :zip_code, presence: true, 
										 numericality: true
									# postcode_format: { country_code: :us,
									# 												message: 'is not a valid postcode for the US.'}
  
    before_validation :remove_blank_categories
  end

  def remove_blank_categories
    self.categories.reject!(&:empty?)
  end
end