# Included in User, Contractor, Jobs
module Validations
	extend ActiveSupport::Concern
	included do

		before_save :remove_blank_categories

		phony_normalize :phone, default_country_code: 'US'
		validates :phone, phony_plausible: true

		validates :zip_code, presence: true, 
										 numericality: true, 
										 			 length: { is: 5 }, 
											allow_blank: false, 
															 if: Proc.new { |m| !m.new_record? }
  end

  def remove_blank_categories
    self.categories.reject! { |c| c.empty? }
  end
end