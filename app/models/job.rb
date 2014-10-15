class Job < ActiveRecord::Base
  belongs_to :user
  belongs_to :contractor
  has_many :posts, dependent: :destroy
end
