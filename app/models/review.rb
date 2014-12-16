class Review < ActiveRecord::Base
  # acts_as_nested_set scope: [:reviewable_id, :reviewable_type]

  belongs_to :reviewable, polymorphic: true
  belongs_to :reviewerable, polymorphic: true

  belongs_to :contractor
  belongs_to :user
  belongs_to :job

  # validates :reviewerable,
  #           :reviewable,
  #           :cost,
  #           :timeliness,
  #           :professionalism,
  #           :recommendation,
  #           :contractor_id,
  #           :description, presence: { message: 'wtd?' }


end
