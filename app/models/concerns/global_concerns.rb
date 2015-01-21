# Included in User, Contractor, Job, Example
module GlobalConcerns
	extend ActiveSupport::Concern
  included do
    scope :relevant_categories, -> (categories){ where('categories && ARRAY[?]', categories) }
    scope :relevant_categories_count, -> (categories){ where('categories && ARRAY[?]', categories).count }

    before_validation :remove_blank_categories
		before_validation :remove_false_categories
  end

	module ClassMethods
    def zip_search(query)
      if query.present?
        near(query, 100).order(:created_at)
      else
        scoped
      end
    end
  end

  def remove_blank_categories
    self.categories.reject!(&:empty?)
  end

	def remove_false_categories
		self.categories.delete_if { |cat| !Contractor.categories.include?(cat) }
	end

  def full_address
    self.address
  end
end
