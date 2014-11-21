class Search < ActiveRecord::Base

	validates :zip_code, presence: true, 
									 numericality: true


  def readonly?
	  !new_record?
	end
end