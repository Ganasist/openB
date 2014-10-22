class User < ActiveRecord::Base

  include Validations
  include Attachments
  include Devisable

	has_many :jobs

  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  def user?
    true
  end

  def contractor?
    false
  end
end
