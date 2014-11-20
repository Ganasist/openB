# Included in User, Contractor, Job, Example
module GlobalConcerns
	extend ActiveSupport::Concern
	
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
    "#{ self.try(:address) }, 
     #{ self.try(:city) }, 
     #{ self.try(:zip_code) }, 
     #{ self.try(:state) }"
  end
end