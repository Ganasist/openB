# Included in Job, Example
module JobValidations
	extend ActiveSupport::Concern
	included do
		validates :categories, presence: true, 
														 length: { minimum: 1,
														 					 maximum: 4, 
														 		   		 message: 'Pick between 1-4 categories' }

		validates :title, presence: true, 
	                      length: { in: 5..50 }

    validates :description, presence: true,
	                            length: { in: 5..2000 }

  end
end