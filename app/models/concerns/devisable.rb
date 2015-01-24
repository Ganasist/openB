# Included in User, Contractor
module Devisable
	extend ActiveSupport::Concern
	included do
		devise :lockable, :timeoutable, :database_authenticatable, 
	  			 :registerable, :recoverable, :rememberable, :trackable,
	  			 :validatable, :async
	end
end
