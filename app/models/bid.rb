class Bid < ActiveRecord::Base

  belongs_to :job
  belongs_to :contractor

  validates_associated :job, :contractor

  validates :cost, numericality: { greater_than: 0, message: 'must be a number greater than 0.'}
end
