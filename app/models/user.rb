class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  devise :omniauthable, omniauth_providers: %i[facebook]

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

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy


  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_initialize.tap do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      # user.profile_pic = auth.info.image
      user.save
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
