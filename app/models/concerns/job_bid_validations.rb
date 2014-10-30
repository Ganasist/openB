# Included in Jobs, Bids
module JobBidValidations
	extend ActiveSupport::Concern
	included do

		DURATION_UNITS = ['minutes', 'hours', 'days', 'weeks', 'months']

		validates :duration, 
							:duration_unit, presence: true

		validates	:duration, numericality: true

		validates :duration_unit, inclusion: { in: DURATION_UNITS }
		
  end
end