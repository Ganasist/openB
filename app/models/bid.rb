class Bid < ActiveRecord::Base

  belongs_to :job
  belongs_to :contractor

  validates :cost, numericality: { greater_than: 0, message: 'must be a number greater than 0.'}
  validates :contractor_id, uniqueness:{ scope: :job_id, message: 'You can have a single bid per job' }

  def accept
    job.bids.each do |b|
      if b.accepted?
        b.update!(accepted: false)
      end
    end

    update!(accepted: true)
  end

  def reject
    update!(accepted: false, rejected: true)
  end
end
