class Example < ActiveRecord::Base

  include JobAttachments

  belongs_to :contractor

  DURATION_UNITS = ['hours', 'days', 'weeks', 'months']
  

  def full_address
    "#{ self.contractor.try(:address) }, 
    #{ self.contractor.try(:city) }, 
    #{ self.contractor.try(:zip_code) }, 
    #{ self.contractor.try(:state) }"
  end
end
