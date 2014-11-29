# Included in User, Contractor, Job, Example
module GlobalConcerns
	extend ActiveSupport::Concern

  included do

    acts_as_commentable
    
    # scope :relevant_categories, -> (categories){ where('category @> ARRAY[?]', categories) }
    # scope :relevant_categories_count, -> (categories){ where('category @> ARRAY[?]', categories).count }


    has_many :uploads, as: :uploadable, dependent: :destroy
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

  def full_address
    "#{ self.try(:address) }, 
     #{ self.try(:city) }, 
     #{ self.try(:zip_code) }, 
     #{ self.try(:state) }"
  end
end