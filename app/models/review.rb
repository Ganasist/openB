class Review < ActiveRecord::Base
  belongs_to :reviewable, polymorphic: true
  belongs_to :reviewerable, polymorphic: true

  # belongs_to :contractor
  belongs_to :user
  belongs_to :job

  validates :reviewerable,
            :reviewable, presence: { message: 'is missing a reviewer and / or a reviewed item'}

  validates :quality,
            :cost,
            :timeliness,
            :professionalism,
            :recommendation, presence: true,
                         numericality: true,
                            inclusion: { in: 0..10,
                                    message: 'Ratings must be between 0 and 10' }

  def self.categories
    %i(quality cost timeliness professionalism recommendation)
  end
end
