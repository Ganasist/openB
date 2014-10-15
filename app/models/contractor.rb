class Contractor < ActiveRecord::Base
	
	has_many :posts

  devise :confirmable, :lockable, :timeoutable, :database_authenticatable, 
  			 :registerable, :confirmable, :recoverable, :rememberable, :trackable, 
  			 :validatable, :async
end
