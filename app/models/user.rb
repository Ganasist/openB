class User < ActiveRecord::Base

	has_many :posts

  devise :confirmable, :lockable, :timeoutable, :invitable, :database_authenticatable, 
  			 :registerable, :confirmable, :recoverable, :rememberable, :trackable, 
  			 :validatable, :async


  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end
end
