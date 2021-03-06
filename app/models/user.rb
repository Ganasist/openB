class User < ActiveRecord::Base

  include MemberValidations
  include Devisable
  include GlobalConcerns

	has_many :jobs
  has_many :bids, through: :jobs

  validates :name, presence: true

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
