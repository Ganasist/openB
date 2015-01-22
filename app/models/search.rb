class Search < ActiveRecord::Base

	attr_accessor :distance

	validates :zip_code, numericality: true, presence: true
	validates :distance, numericality: true

  def readonly?
	  !new_record?
	end
end
