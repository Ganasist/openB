# Included in User, Contractor
module MemberValidations
	extend ActiveSupport::Concern
	included do
		has_many :comments, as: :commenterable, dependent: :destroy
		has_many :reviews, as: :reviewerable, dependent: :destroy

		validates :categories, presence: true,
														 length: { minimum: 1,
														 					 maximum: 4,
														 		   		 message: 'Pick between 1-4 categories' },
																 if: Proc.new { |o| !o.new_record? }

		geocoded_by :address
		validates :address, presence: true

		phony_normalize :phone, default_country_code: 'US'
		validates :phone, phony_plausible: true

		validates :name, presence: true, if: Proc.new { |o| !o.new_record? }
  end

	def average_quality
		reviews.average(:quality).round(1)
	end


	def average_cost
		reviews.average(:cost).round(1)
	end


	def average_timeliness
		reviews.average(:timeliness).round(1)
	end


	def average_professionalism
		reviews.average(:professionalism).round(1)
	end


	def average_recommendation
		reviews.average(:recommendation).round(1)
	end
end
