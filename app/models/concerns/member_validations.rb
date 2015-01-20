# Included in User, Contractor
module MemberValidations
	extend ActiveSupport::Concern
	included do
		before_save :ensure_authentication_token

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

	def ensure_authentication_token
		if authentication_token.blank?
			self.authentication_token = generate_authentication_token
		end
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

	private
		def generate_authentication_token
			loop do
				token = Devise.friendly_token
				break token unless self.class.exists?(authentication_token: token)
			end
		end
end
