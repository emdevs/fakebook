class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  #Friend Requests
  has_many :sent_friend_requests, foreign_key: "requester_id", class_name: "FriendRequest"
  has_many :pending_friend_requests, foreign_key: "reciever_id", class_name: "FriendRequest"


  #Friendships
  has_many :friendships_as_a, class_name: "Friendship", foreign_key: "friend_a_id" #user_id = friend_a_id
  has_many :friendships_as_b, class_name: "Friendship", foreign_key: "friend_b_id"

  has_many :friends_as_a, through: :friendships_as_a, source: "friend_b" #source is the obj ur grabbing
  has_many :friends_as_b, through: :friendships_as_b, source: "friend_a"

  #all friends
  def friends
    self.friends_as_a + self.friends_as_b
  end

  scope :other_users, ->(user_id){where("id != ?", user_id)}

  has_many :posts



end
