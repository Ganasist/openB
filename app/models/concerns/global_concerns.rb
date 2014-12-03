# Included in User, Contractor, Job, Example
module GlobalConcerns
	extend ActiveSupport::Concern
  included do

    acts_as_commentable
    
    scope :relevant_categories, -> (categories){ where('categories @> ARRAY[?]', categories) }
    scope :relevant_categories_count, -> (categories){ where('categories @> ARRAY[?]', categories).count }

    has_many :uploads, as: :uploadable, dependent: :destroy
    before_validation :remove_blank_categories
  end
	
	module ClassMethods
    def zip_search(query)
      if query.present?
        near(query, 50).order(:updated_at).reverse_order
      else
        scoped
      end
    end
  end

  def remove_blank_categories
    self.categories.reject!(&:empty?)
  end

  def full_address
    self.address
  end
end