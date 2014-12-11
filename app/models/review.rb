class Review < ActiveRecord::Base
  belongs_to :job

  ratyrate_rateable 'cost', 'timeliness', 'professionalism'
end
