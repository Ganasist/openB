class Review < ActiveRecord::Base
  belongs_to :contractor
  belongs_to :user
  belongs_to :job

end
