class Post < ActiveRecord::Base
  belongs_to :job
  belongs_to :contractor
  belongs_to :user
end
