# Included in Job, Example
module JobValidations
	extend ActiveSupport::Concern
	included do

    scope :relevant_categories, -> (categories){ where('category @> ARRAY[?]', categories) }
    scope :relevant_categories_count, -> (categories){ where('category @> ARRAY[?]', categories).count }

		validates :category, presence: true, 
													 length: { is: 1,
										 		   		  message: 'Pick a category' }

		validates :title, presence: true, 
	                      length: { in: 5..50 }

    validates :description, presence: true,
	                            length: { in: 5..2000 }

  end
end