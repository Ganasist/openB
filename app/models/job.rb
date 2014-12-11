class Job < ActiveRecord::Base

  include JobValidations
  include PgSearch
  include GlobalConcerns

  belongs_to :user

  geocoded_by :address
  validates :address, presence: true

  has_many :reviews

  has_many :bids, dependent: :destroy
  has_many :contractors, through: :bids

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



  include AASM
  #
  # enum state: {
  #   searching: 1,
  #   in_progress: 2,
  #   completed: 3,
  #   incomplete: 4,
  #   cancelled: 5
  # }

  aasm column: :state, whiny_transitions: false do
    state :searching, initial: true
    state :in_progress
    state :complete
    state :incomplete
    state :cancelled

    event :activate do
      transitions from: :searching, to: :in_progress
    end

    event :complete do
      transitions from: :in_progress, to: :compelete
    end

    event :mark_as_incomplete do
      transitions from: :in_progress, to: :incomplete
    end

    event :cancel do
      transitions from: [:searching, :in_progress, :incomplete], to: :cancelled
    end
  end

end
