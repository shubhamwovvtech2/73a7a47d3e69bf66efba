class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, :foreign_key => "user_id",:class_name => "Tweet" 
  has_many :follows, :foreign_key => "user_id",:class_name => "Follow"


  def self.tweets
  	@tweets = current_user.tweets
  end
  def self.user_followings
      @followings = User.where(id: current_user.follows.pluck(:following_id))
  end
end
