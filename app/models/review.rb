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
                             greater_than_or_equal_to: 0,
                                less_than_or_equal_to: 10,
                                              message: 'Ratings must between 0 and 10' }

  private
    def adjust_ratings
      pluck(:quality, :cost, :timeliness).each do |t|
        puts t
      end
    end
end
