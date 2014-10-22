class Bid < ActiveRecord::Base
  belongs_to :job
  belongs_to :contractor
end
