class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, :foreign_key => "user_id",:class_name => "Tweet" 
  has_many :follows, :foreign_key => "followed_by_id",:class_name => "Follow"
end
