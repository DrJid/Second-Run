class Relationship < ActiveRecord::Base
  attr_accessible :followed_id, 

  #We dont' want the :follower_id to editable by the web. That information comes from you 
  # the logged in user For that reason, we got rid of the :follower_id
  # In other words, in attr_accessible you should get rid of things you don't want to 
  # change in t web form


  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true

end
