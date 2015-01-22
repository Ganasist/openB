class Contractor < ActiveRecord::Base

  include MemberValidations
  include Devisable
  include GlobalConcerns
  include PgSearch

  validates :search_radius, numericality: { only_integer: true,
                                             allow_blank: true,
                                            greater_than: 0,
                                               less_than: 1000,
                                                 message: 'Please choose a distance between 1 - 999 miles.' }

  has_many :bids
  has_many :jobs
  has_many :reviews, through: :jobs

  has_many :examples, dependent: :destroy
  has_many :uploads, through: :examples

  validates :company_name, presence: true

  def self.categories
    ['Art', 'Bathrooms', 'Custom Furniture', 'Driveways', 'Decks / Patios', 'Electrical', 'Fencing', 'Flooring', 'Heating and Cooling',
     'Home','Security', 'Interior Design', 'Kitchens', 'Landscaping', 'Moving', 'New Construction',
    	'Painting', 'Pest Control', 'Pools', 'Plumbing', 'Remodel', 'Roofing', 'Siding',
    	'Stone and Gravel', 'Windows and Doors']
  end

  def self.splash_page_categories
    ['Driveways', 'Electrical', 'Landscaping', 'New Construction',
	  	'Painting','Plumbing', 'Remodel', 'Roofing' ]
  end

  def complete_profile?
    name.present? &&
    company_name.present? &&
    address.present? &&
    description.present? &&
    categories.present?
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
