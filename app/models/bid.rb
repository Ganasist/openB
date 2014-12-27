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
    update!(rejected: false, accepted: true)
    # send message
  end

  def reject
    update!(accepted: false, rejected: true)
    #send message
  end
end
