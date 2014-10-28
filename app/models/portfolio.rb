class Portfolio < ActiveRecord::Base
  belongs_to :job
  belongs_to :contractor
  has_many :examples

  # validates_associated :contractor
end
