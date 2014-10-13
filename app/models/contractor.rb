class Contractor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  and :omniauthable
  devise :confirmable, :lockable, :timeoutable, :database_authenticatable, 
  			 :registerable, :confirmable, :recoverable, :rememberable, :trackable, 
  			 :validatable
end
