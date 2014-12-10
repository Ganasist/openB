class User < ActiveRecord::Base

  include MemberValidations
  include Devisable
  include GlobalConcerns

  ratyrate_rater

	has_many :jobs

  def fullname
    self.name || self.email
  end

  def complete_profile?
    self.name.present? && 
    self.address.present? &&
    self.categories.present?
  end

  def user?
    true
  end

  def contractor?
    false
  end
end
