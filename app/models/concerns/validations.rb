# Included in User, Contractor, Jobs
module Validations
	extend ActiveSupport::Concern
	included do
		# validates_inclusion_of :categories, in: Contractor.categories, message: 'Invalid Category'
		before_save :remove_blank_categories
  end

  def remove_blank_categories
    self.categories.reject! { |c| c.empty? }
  end
end