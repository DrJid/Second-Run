class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user 

  validates :user_id, presence: true
    # validates :name, presence: true , length: { maximum: 50 , minimum: 2 }
  validates :content, presence: true, length: { maximum: 140 }


  default_scope order: "microposts.created_at DESC"
end
