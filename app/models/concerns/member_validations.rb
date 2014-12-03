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

		geocoded_by :address
		validates :address, presence: true
		
		phony_normalize :phone, default_country_code: 'US'
		validates :phone, phony_plausible: true

		validates :name, presence: true, if: Proc.new { |o| !o.new_record? }
  end
end