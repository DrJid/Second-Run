class User < ActiveRecord::Base
  attr_accessible :email, :name , :password, :password_confirmation#Any attributable editable throught a web form should
  #be on this list. 
  #Mass assignment. 
  has_secure_password

  before_save { |user| user.email = user.email.downcase }

  #Validating 
  validates :name, presence: true , length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[\w+\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  			uniqueness: { case_sensitive: false } 

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

end
