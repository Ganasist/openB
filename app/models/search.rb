class Search < ActiveRecord::Base

	attr_accessor :distance
	attr_accessor :latitude
	attr_accessor :longitude

	validates :zip_code, numericality: true, allow_blank: true
	validates :distance, presence: true
	validates :latitude, numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }, allow_blank: true
	validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }, allow_blank: true

  def readonly?
	  !new_record?
	end
end
