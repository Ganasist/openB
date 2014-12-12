class Job < ActiveRecord::Base

  include JobValidations
  include PgSearch
  include GlobalConcerns

  belongs_to :user
  belongs_to :contractor

  geocoded_by :address
  validates :address, presence: true

  has_one :review

  has_many :bids, dependent: :destroy

  validates :bidding_period, allow_blank: true,
                                    date: { after: Proc.new { Date.today },
                                          message: 'Must be a future date' },
                                      if: Proc.new { |o| o.new_record? }


  before_validation :add_default_location, if: Proc.new { |j| j.address.blank?  }
  def add_default_location
    self.address = self.user.address
    self.longitude = self.user.longitude
    self.latitude = self.user.latitude
  end

  def has_coordinates?
    longitude.present? && latitude.present?
  end

  # State manager to handle how jobs transition

  include AASM

  aasm column: :state, whiny_transitions: false do
    state :searching, initial: true
    state :in_progress
    state :complete
    state :incomplete
    state :cancelled

    event :activate do
      transitions from: :searching, to: :in_progress, after: Proc.new { |this_bid| set_contractor(this_bid) }
    end

    event :resume_search, after: :reset_contractors do
      transitions to: :searching
    end

    event :mark_as_complete do
      transitions from: :in_progress, to: :complete
    end

    event :mark_as_incomplete do
      transitions from: :in_progress, to: :incomplete
    end

    event :cancel do
      transitions from: [:searching, :in_progress, :incomplete], to: :cancelled
    end
  end

  def set_contractor(this_bid)
    reset_contractors
    bid_reset(this_bid, true, false)
    self.contractor = this_bid.contractor
    # Email / Message contractor & user
  end

  def reset_contractors
    self.bids.each do |b|
      bid_reset(b, false, false)
    end
    self.contractor_id = nil
  end

  def remove_contractors
    self.bids.each do |b|
      bid_reset(b, false, true)
    end
    self.contractor_id = nil
  end

  def bid_reset(b, accept, reject)
    b.update_attributes!(accepted: accept, rejected: reject)
  end
end
