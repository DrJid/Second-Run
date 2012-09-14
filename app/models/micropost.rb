class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user 

  validates :user_id, presence: true
    # validates :name, presence: true , length: { maximum: 50 , minimum: 2 }
  validates :content, presence: true, length: { maximum: 140 }


  default_scope order: "microposts.created_at DESC"

  def self.from_users_followed_by(user)
  	# following_ids = user.followed_users.map(&:id)
  	# following_ids = user.followed_user_ids #ACtive Record knows. 
  	followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
  	where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", 
  		{ user_id: user.id })
  end
end
