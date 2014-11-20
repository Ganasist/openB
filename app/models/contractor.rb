class Contractor < ActiveRecord::Base

  include MemberValidations
  include Devisable
  include GlobalConcerns
  include PgSearch
  
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

  private
    # def self.zip_search(query)
    #   if query.present?
    #     where("zip_code = :q", q: query)
    #   else
    #     scoped
    #   end
    # end
end
