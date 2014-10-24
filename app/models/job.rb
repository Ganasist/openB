class Job < ActiveRecord::Base

  include Attachments
  include GeneralValidations
  include JobBidValidations

  include PgSearch
  pg_search_scope :search_by_zip, against: :zip_code
  
  belongs_to :user
  validates_associated :user
  
  has_many :bids
  has_many :contractors, through: :bids

  validates :title, presence: true, allow_blank: false, length: { in: 5..50 }
  validates :description, presence: true, allow_blank: false, length: { in: 10..2000 }

  before_validation :add_default_zip_code, if: Proc.new { |j| j.zip_code.blank? }

  def add_default_zip_code
  	self.zip_code = self.user.zip_code
  end

  private
    # def self.zip_search(query)
    #   if query.present?
    #     where("zip_code = :q", q: query)
    #   else
    #     scoped
    #   end
    # end
end
