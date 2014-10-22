class Contractor < ActiveRecord::Base
	
  include Validations
  include Attachments
  include Devisable

  has_many :bids
  has_many :jobs, through: :bids

  validates :phone, 
            :address, 
            :city, 
            :state, 
            :company_name, 
            :bio, presence: true, if: Proc.new { |m| !m.new_record? }

  def self.categories
    ['Bathrooms', 'Driveways', 'Decks/patios', 'Electrical', 'Fencing', 'Flooring', 'Home', 
    	'Security', 'Interior Design', 'Kitchens', 'Landscaping', 'Moving', 'New Construction',
    	'Painting', 'Pest Control', 'Pools', 'Plumbing', 'Remodel', 'Roofing', 'Siding',
    	'Stone and Gravel', 'Windows and Doors']
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
