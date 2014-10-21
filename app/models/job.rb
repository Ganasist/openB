class Job < ActiveRecord::Base

  include Attachments
  include Validations
  
  belongs_to :user
  belongs_to :contractor

  validates :title, presence: true, allow_blank: false, length: { in: 5..50 }
  validates :description, presence: true, allow_blank: false, length: { in: 10..500 }
  validates :categories, presence: true, length: { maximum: 3, message: 'Pick between 1-3 categories' }

  before_validation :add_default_zip_code, if: Proc.new { |j| j.zip_code.blank? }

  def add_default_zip_code
  	self.zip_code = self.user.zip_code
  end

  def self.duration_units
    ['minutes', 'hours', 'days', 'weeks', 'months']
  end

end
