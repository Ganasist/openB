class Job < ActiveRecord::Base

  enum status: { searching: 0, in_progress: 1, completed: 2, canceled: 3 }

  ratyrate_rateable 'cost', 'timeliness', 'professionalism'

  include JobValidations
  include PgSearch
  include GlobalConcerns
  
  belongs_to :user

  geocoded_by :address
  validates :address, presence: true

  has_many :bids, dependent: :destroy
  has_many :contractors, through: :bids

  validates :bidding_period, allow_blank: true, 
                                    date: { after: Proc.new { Date.today }, 
                                          message: 'Must be a future date' }, 
                                      if: Proc.new { |o| o.new_record? }


  before_validation :add_default_location, if: Proc.new { |j| j.address.blank?  }
  def add_default_location
    self.address = self.user.address
    self.longitude = self.user.longitude
    self.latitude = self.user.latitude
  end
end
