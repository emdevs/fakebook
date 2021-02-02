class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :sent_friend_requests, foreign_key: "requester_id", class_name: "FriendRequest"
  has_many :pending_friend_requests, foreign_key: "reciever_id", class_name: "FriendRequest"

  has_many :friendships_as_a, class_name: "Friendship", foreign_key: "friend_a_id" #user_id = friend_a_id
  has_many :friendships_as_b, class_name: "Friendship", foreign_key: "friend_b_id"

  has_many :friends_as_a, through: :friendships_as_a, source: "friend_b" #source is the obj ur grabbing
  has_many :friends_as_b, through: :friendships_as_b, source: "friend_a"

  def friends
    self.friends_as_a + self.friends_as_b
  end

  has_many :posts
end

# has_many :friendships, ->{where("friend_a_id = 2")}
  # has_many :friendships, -> (user){where("friend_a_id = ? OR friend_b_id = ?", user.id, user.id)}
  # has_many :friends, through: :friendships

  # has_many :friendships_as_a, foreign_key: "friend_a_id", class_name: "Friendship"
  # has_many :friendships_as_b, foreign_key: "friend_b_id", class_name: "Friendship"

  # has_many :friends, through: :friendships_as_a, source: "friend_b"