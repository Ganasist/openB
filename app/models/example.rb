class Example < ActiveRecord::Base
  belongs_to :portfolio

  validates_associated :portfolio
end
