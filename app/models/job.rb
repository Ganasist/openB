class Job < ActiveRecord::Base

  include Attachments
  include Validations
  
  belongs_to :user
  belongs_to :contractor

  validates :title, presence: true, allow_blank: false, length: { in: 5..50 }
  validates :description, presence: true, allow_blank: false, length: { in: 10..500 }
  validates :categories, presence: true, length: { maximum: 3, message: 'Pick between 1-3 categories' }

end
