class Search < ActiveRecord::Base

	attr_readonly :zip_code

	validates :zip_code, presence: true, 
									 numericality: true


end