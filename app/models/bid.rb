class Bid < ActiveRecord::Base

  belongs_to :job
  belongs_to :contractor

  validates :cost, numericality: { greater_than: 0, message: 'must be a number greater than 0.'}
  validates :contractor_id, uniqueness:{ scope: :job, message: 'You can have a single bid per job' }
end
