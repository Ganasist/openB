class Review < ActiveRecord::Base
  belongs_to :contractor
  belongs_to :user
  belongs_to :job

  ratyrate_rateable 'cost', 'timeliness', 'professionalism'
end
