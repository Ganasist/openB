class Job < ActiveRecord::Base

  include Attachments
  # include Validations
  
  belongs_to :user
  belongs_to :contractor
  has_many :posts, dependent: :destroy
end
