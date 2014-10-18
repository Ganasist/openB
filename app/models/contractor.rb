class Contractor < ActiveRecord::Base
	
  include Validations
  include Attachments
  include Devisable
  
	has_many :jobs
	has_many :users, through: :jobs
	
	has_many :posts

  before_save :remove_blank_categories

  def self.categories
    ['Bathrooms', 'Driveways', 'Decks/patios', 'Electrical', 'Fencing', 'Flooring', 'Home', 
    	'Security', 'Interior Design', 'Kitchens', 'Landscaping', 'Moving', 'New Construction',
    	'Painting', 'Pest Control', 'Pools', 'Plumbing', 'Remodel', 'Roofing', 'Siding',
    	'Stone and Gravel']
  end

  def self.splash_page_categories
    ['Driveways', 'Electrical', 'Landscaping', 'New Construction',
	  	'Painting','Plumbing', 'Remodel', 'Roofing' ]
  end

  def user?
    false
  end

  def contractor?
    true
  end
end
