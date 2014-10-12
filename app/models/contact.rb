class Contact
	include ActiveAttr::Model

	attribute :name
  attribute :email
  attribute :subject
  attribute :comment

  attr_accessor :name
  attr_accessor :email
  attr_accessor :subject
  attr_accessor :comment
  
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :comment, message: "Comment can't be blank"
  
  validates_format_of :email, with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
  validates_length_of :comment, maximum: 223
end