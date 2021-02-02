class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :sent_friend_requests, foreign_key: "requester_id", class_name: "FriendRequest"
  has_many :pending_friend_requests, foreign_key: "reciever_id", class_name: "FriendRequest"

  has_many :friendships, ->(user) { where("friend_a_id = ? OR friend_b_id = ?", user.id, user.id) }
  has_many :friends, through: :friendships

  has_many :posts
end

