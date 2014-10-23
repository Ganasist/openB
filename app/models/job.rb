class Job < ActiveRecord::Base

  include Attachments
  include Validations
  
  belongs_to :user
  
  has_many :bids
  has_many :contractors, through: :bids

  DURATION_UNITS = ['minutes', 'hours', 'days', 'weeks', 'months']

  validates :cost, :duration, :duration_unit, presence: true
  validates :cost, :duration, numericality: true
  validates :duration_unit, inclusion: { in: DURATION_UNITS }
  validates :title, presence: true, allow_blank: false, length: { in: 5..50 }
  validates :description, presence: true, allow_blank: false, length: { in: 10..2000 }
  validates :categories, presence: true, length: { maximum: 4, message: 'Pick between 1-4 categories' }

  before_validation :add_default_zip_code, if: Proc.new { |j| j.zip_code.blank? }

  def add_default_zip_code
  	self.zip_code = self.user.zip_code
  end
end
