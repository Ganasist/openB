class Search < ActiveRecord::Base

	attr_accessor :distance
	attr_accessor :latitude
	attr_accessor :longitude
	attr_accessor :categories

	validates :zip_code, numericality: true, presence: true, if: Proc.new { |s| s.latitude.blank? || s.longitude.blank? }
	validates :distance, numericality: { greater_than_or_equal_to:  1, less_than_or_equal_to:  999 }, allow_blank: true
	validates :latitude, numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }, presence: true, if: Proc.new { |s| s.zip_code.blank? }
	validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }, presence: true, if: Proc.new { |s| s.zip_code.blank? }

  def readonly?
	  !new_record?
	end
end
