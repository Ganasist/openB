class Job < ActiveRecord::Base

  include JobValidations
  include PgSearch
  include GlobalConcerns
  pg_search_scope :search_by_zip, against: :zip_code
  
  belongs_to :user

  has_many :bids, dependent: :destroy
  has_many :contractors, through: :bids

  validates :zip_code, numericality: true

  validates :bidding_period, allow_blank: true, 
                                    date: { after: Proc.new { Date.today }, 
                                          message: 'Must be a future date' }

  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.full_address.present? && (obj.address_changed? ||
                                                                        obj.zip_code_changed? ||
                                                                        obj.city_changed? ||
                                                                        obj.state_changed?) }


  before_validation :add_default_zip_code, if: Proc.new { |j| j.zip_code.blank? }
  def add_default_zip_code
    self.zip_code = self.user.zip_code
  end

  def full_address
    "#{ self.try(:address) }, 
     #{ self.try(:city) }, 
     #{ self.try(:zip_code) }, 
     #{ self.try(:state) }"
  end
end
