class Job < ActiveRecord::Base

  include Attachments
  
  belongs_to :user
  belongs_to :contractor
  has_many :posts, dependent: :destroy
end
