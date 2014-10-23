class Bid < ActiveRecord::Base

	include JobBidValidations

  belongs_to :job
  belongs_to :contractor

  validates_associated :job, :contractor

  # validates :cost, :duration, :duration_unit, presence: true
end
