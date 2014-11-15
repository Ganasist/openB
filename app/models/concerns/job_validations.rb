# Included in Job, Example
module JobValidations
	extend ActiveSupport::Concern
	included do

		acts_as_commentable

		
	  has_many :uploads, as: :uploadable, dependent: :destroy

		before_validation :remove_blank_categories

		scope :relevant_categories, -> (categories){ where('categories && ARRAY[?]', categories) }
		scope :relevant_categories_count, -> (categories){ where('categories && ARRAY[?]', categories).count }

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

  end

  def remove_blank_categories
    self.categories.reject!(&:empty?)
  end
end