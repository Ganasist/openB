class Review < ActiveRecord::Base
  # acts_as_nested_set scope: [:reviewable_id, :reviewable_type]

  belongs_to :reviewable, polymorphic: true
  belongs_to :reviewerable, polymorphic: true

  belongs_to :contractor
  belongs_to :user
  belongs_to :job

  validates :reviewerable,
            :reviewable, presence: { message: 'is missing a reviewer and / or a reviewed item'}

  validates :quality,
            :cost,
            :timeliness,
            :professionalism,
            :recommendability, presence: { message: 'Please provide a rating for each criteria' },
                           numericality: { only_integer: true,
                                                message: 'Ratings must be between 0 and 10' },
                              inclusion: { in: 0..10,
                                      message: 'Ratings must be between 0 and 10' }

end
