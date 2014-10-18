# Included in User, Contractor
module Validations
	extend ActiveSupport::Concern
	included do
		before_save :remove_blank_categories
  end

  def remove_blank_categories
    self.categories.reject! { |c| c.empty? }
  end
end