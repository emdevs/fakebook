class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  validates :name, length: {minimum: 2}
  has_one_attached :profile_pic

  #Friend Requests (true = accepted, false = pending, rejected means request is auto-deleted)
  has_many :sent_friend_requests, foreign_key: "requester_id", class_name: "FriendRequest"
  has_many :pending_friend_requests, foreign_key: "reciever_id", class_name: "FriendRequest"

  def friends_ids
    ids_as_requester = FriendRequest.where(requester_id: self.id, status: true).pluck(:reciever_id) #save memeory or speed i guess since no active reccord objects are returned
    ids_as_reciever = FriendRequest.where(reciever_id: self.id, status: true).pluck(:requester_id)
    total_ids = ids_as_reciever + ids_as_requester
  end

  def friends?(user)
  end

  def friends
    User.where(id: self.friends_ids)
  end

  def can_send_request
    #All user ids that fail conditions (to be sent a new friend_request) below
    a = FriendRequest.where(requester_id: self.id, status: false).pluck(:reciever_id)
    b = FriendRequest.where(reciever_id: self.id, status: false).pluck(:requester_id)
    c = self.friends_ids
    d = self.id

    all_ids = a+b+c
    all_ids << self.id
    User.where.not(id: all_ids)
  end

  def pending_invitees
    ids = FriendRequest.where(requester_id: self.id, status: false).pluck(:reciever_id)
    User.where(id: ids)
  end

  def invites_from
    ids = FriendRequest.where(reciever_id: self.id, status: false).pluck(:requester_id)
    User.where(id: ids)
  end

  has_many :posts
  has_many :likes
  has_many :comments
end

  #friendship part 2
  # has_many :friendships, ->(user) {unscope(:where).where(friend_a: user).or(where(friend_b: user))}

  