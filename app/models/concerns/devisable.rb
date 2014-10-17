module Devisable
	extend ActiveSupport::Concern
	included do
		devise :lockable, :timeoutable, :invitable, :database_authenticatable, 
	  			 :registerable, :recoverable, :rememberable, :trackable, 
	  			 :validatable, :async
	end
end