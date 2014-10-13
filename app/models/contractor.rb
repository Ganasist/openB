class Contractor < ActiveRecord::Base
	
  devise :confirmable, :lockable, :timeoutable, :database_authenticatable, 
  			 :registerable, :confirmable, :recoverable, :rememberable, :trackable, 
  			 :validatable
end
