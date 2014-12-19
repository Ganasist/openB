class Bid < ActiveRecord::Base

  belongs_to :job
  belongs_to :contractor

  validates :cost, numericality: { greater_than: 0,
                                        message: 'must be a number greater than 0.' }
  validates :contractor_id, uniqueness:{ scope: :job_id,
                                       message: 'You can have a single bid per job' }

  def status
    if accepted?
      'Accepted'
    elsif rejected?
      'Rejected'
    else
      'No decision yet'
    end
  end

  def accept
    job.bids.each do |b|
      if b.accepted?
        b.update!(accepted: false)
        # send message?
      end
    end

    update!(accepted: true)
    # send message
  end

  def reject
    update!(accepted: false, rejected: true)
    #send message
  end
end
