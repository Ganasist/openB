class Bid < ActiveRecord::Base

  has_attached_file :pdf
  validates_attachment_content_type :pdf, content_type: 'application/pdf'
  validates_attachment_file_name :pdf, matches: [/pdf\Z/]

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
    update_columns(rejected: false, accepted: true)
  end

  def reject
    update!(accepted: false, rejected: true)
    #send message
  end
end
