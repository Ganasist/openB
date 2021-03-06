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
    def zip_search(query, distance = 50)
      near(query, distance).order(:created_at)
    end

		def lat_lon_search(latitude, longitude, distance = 50)
			near([latitude, longitude], distance).order(:created_at)
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
