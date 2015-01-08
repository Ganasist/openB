# Included in User, Contractor
module MemberValidations
	extend ActiveSupport::Concern
	included do
		acts_as_messageable class_name: 'Message'

		has_one :upload, as: :uploadable,
							dependent: :destroy
		accepts_nested_attributes_for :upload, reject_if: :all_blank,
																			 allow_destroy: true

		has_many :reviews, as: :reviewerable,
								dependent: :destroy

		validates :categories, presence: true,
														 length: { minimum: 1,
														 					 maximum: 4,
														 		   		 message: 'Pick between 1-4 categories' },
																 if: Proc.new { |o| !o.new_record? }

		geocoded_by :address
		validates :address, presence: true

		phony_normalize :phone, default_country_code: 'US'
		validates :phone, phony_plausible: true
  end

	def mailboxer_email(object)
		return self.email
	end

	def mailboxer_name
		self.fullname
	end

	def review_average_single(param)
		reviews.average(param).round(1)
	end

	def review_average_total
		test = 0
		Review.categories.each do |param|
			test += review_average_single(param)
		end
		return (test / Review.categories.length).round(1)
	end
end
