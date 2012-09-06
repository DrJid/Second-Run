class User < ActiveRecord::Base
  attr_accessible :email, :name , :password, :password_confirmation#Any attributable editable throught a web form should
  #be on this list. # Put on this list if you don't want that Mass assignment thing.
  has_secure_password




  #Keeping everything downcase in the database. 
  # before_save { |user| user.email = user.email.downcase }
  before_save { self.email.downcase! } #This is another implementation of the before save callback
  #We need another callback that will create the remember_token before saving to the database
  before_save :create_remember_token 


  #Validating 
  validates :name, presence: true , length: { maximum: 50 , minimum: 2 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[\w+\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  			uniqueness: { case_sensitive: false } 

  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true


  private

    def create_remember_token
        self.remember_token = SecureRandom.urlsafe_base64
    end

end
