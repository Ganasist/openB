class Example < ActiveRecord::Base

  include JobValidations
  include GlobalConcerns

  belongs_to :contractor

  DURATION_UNITS = ['hours', 'days', 'weeks', 'months']

  before_validation :add_default_location, if: Proc.new { |j| j.latitude.blank? || j.longitude.blank? || j.address.blank? }
   def add_default_location
    self.address = self.contractor.address
    self.longitude = self.contractor.longitude
    self.latitude = self.contractor.latitude
  end

  def before_uploads
    self.uploads.where(before: true)
  end

  def after_uploads
    self.uploads.where(after: true)
  end
end
