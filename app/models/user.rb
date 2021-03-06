class User < ActiveRecord::Base
  attr_accessible :email, :name , :password, :password_confirmation#Any attributable editable throught a web form should
  #be on this list. # Put on this list if you don't want that Mass assignment thing.
  has_secure_password
  has_many :microposts,  dependent: :destroy
  #In the case of micropost, rails knows we want the foreign key to be user_id by default.
  # 3In the case of relationships, we have to tell rails explicitly
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed 

#We use the reverse relationships for extra stuff 
#Since there is no reverse relationship model, we need to do that explicitly through
# a class name
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship" , dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower





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

  def feed
    #This is only a proto-feed
    # self.microposts
    # Micropost.where("user_id = ?", id)
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    self.relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    #Create! will raise an exception if there is an error. 
    self.relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    self.relationships.find_by_followed_id(other_user.id).destroy
  end

  private

    def create_remember_token
        self.remember_token = SecureRandom.urlsafe_base64
    end

end
