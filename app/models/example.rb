class Example < ActiveRecord::Base

  include JobValidations

  has_many :uploads, as: :uploadable, dependent: :destroy

  belongs_to :contractor

  DURATION_UNITS = ['hours', 'days', 'weeks', 'months']

  def full_address
    "#{ self.contractor.try(:address) }, 
     #{ self.contractor.try(:city) }, 
     #{ self.contractor.try(:zip_code) }, 
     #{ self.contractor.try(:state) }"
  end

  def before_uploads
    self.uploads.where(before: true)
  end

  def after_uploads
    self.uploads.where(after: true)
  end
end
