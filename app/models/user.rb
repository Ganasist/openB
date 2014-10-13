class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # and :omniauthable
  devise :confirmable, :lockable, :timeoutable, :invitable, :database_authenticatable, 
  			 :registerable, :confirmable, :recoverable, :rememberable, :trackable, 
  			 :validatable
end
