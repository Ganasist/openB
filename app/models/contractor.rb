class Contractor < ActiveRecord::Base

  include MemberValidations
  include Devisable
  include GlobalConcerns
  include PgSearch

  after_commit :search_radius_check
  validates :search_radius, numericality: { only_integer: true,
                                             allow_blank: true,
                                            greater_than: 0, 
                                               less_than: 1000, 
                                                 message: 'Please choose a distance between 1 - 999 miles.' }
  
  pg_search_scope :search_by_zip, against: :zip_code

  has_many :bids
  has_many :jobs, through: :bids

  has_many :examples, dependent: :destroy

  def self.categories
    ['Bathrooms', 'Driveways', 'Decks/patios', 'Electrical', 'Fencing', 'Flooring', 'Heating and Cooling',
     'Home','Security', 'Interior Design', 'Kitchens', 'Landscaping', 'Moving', 'New Construction',
    	'Painting', 'Pest Control', 'Pools', 'Plumbing', 'Remodel', 'Roofing', 'Siding',
    	'Stone and Gravel', 'Windows and Doors']
  end

  def self.splash_page_categories
    ['Driveways', 'Electrical', 'Landscaping', 'New Construction',
	  	'Painting','Plumbing', 'Remodel', 'Roofing' ]
  end

  def search_radius_check
    self.search_radius = 50 if self.search_radius.blank?
  end

  def complete_profile?
    self.name.present? && 
    self.company_name.present? && 
    self.zip_code.present? && 
    self.description.present? && 
    self.categories.present?
  end

  def fullname
    self.company_name || self.name || self.email
  end

  def user?
    false
  end

  def contractor?
    true
  end
end
