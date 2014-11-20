# Included in Job, Example
module JobValidations
	extend ActiveSupport::Concern
	included do

		validates :categories, presence: true, 
														 length: { minimum: 1,
														 					 maximum: 4, 
														 		   		 message: 'Pick between 1-4 categories' }


		validates :title, presence: true, 
	                 allow_blank: false, 
	                      length: { in: 5..50 }

    validates :description, presence: true, 
	                       allow_blank: false, 
	                            length: { in: 10..2000 }

  end
end