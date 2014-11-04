class User < ActiveRecord::Base

  include GeneralValidations
  include MemberAttachments
  include Devisable

	has_many :jobs

  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  def complete_profile?
    self.name.present? && 
    self.zip_code.present? &&
    self.categories.present?
  end

  def user?
    true
  end

  def contractor?
    false
  end
end
