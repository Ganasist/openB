class Job < ActiveRecord::Base

  include Attachments
  include Validations
  
  belongs_to :user
  belongs_to :contractor
end
