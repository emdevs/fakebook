class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook]

  validates :name, length: {minimum: 2}
  validates :birth_date, presence: true, if: :validate_age?
  # validates :gender, presence: true (FB signup will fail since cannot retrieve gender (for now, it returns nil))
  after_create :create_profile, :create_status

  enum gender: [:male, :female, :other]
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :profile, dependent: :destroy


  #dependent destory here?
  #Friend Requests (true = accepted, false = pending, rejected means request is auto-deleted)
  has_many :sent_friend_requests, foreign_key: "requester_id", class_name: "FriendRequest"
  has_many :pending_friend_requests, foreign_key: "reciever_id", class_name: "FriendRequest"

  #Chats (as user_1 and user_2)
  has_many :chats_as_user_1, foreign_key: "user_1_id", class_name: "Chat", dependent: :destroy
  has_many :chats_as_user_2, foreign_key: "user_2_id", class_name: "Chat", dependent: :destroy


  #Messages (dependent destroy? we'll see)
  has_many :messages, dependent: :destroy

  #Clubs (if club is destoryed...)
  has_many :owned_clubs, foreign_key: "owner_id", class_name: "Club", dependent: :destroy

  has_many :memberships, foreign_key: "member_id", dependent: :destroy
  has_many :joined_clubs, through: :memberships, source: :club

  #online status
  has_one :status, dependent: :destroy


  #notifications
  #for likes and posts, friend requests dont need notification model (it IS the notification)

  def chat_partner_ids
    ids_as_user_1 = Chat.where(user_1_id: self.id).pluck(:user_2_id)
    ids_as_user_2 = Chat.where(user_2_id: self.id).pluck(:user_1_id)

    ids_as_user_1 + ids_as_user_2
  end

  #grab the users that have a chat have self
  def chat_partners
    User.where(id: chat_partner_ids)
  end

  #find an instance of private chat based on partner id. 
  def chat_with(partner_id)
    self.chats_as_user_1.where(user_2_id: partner_id).or(
      self.chats_as_user_2.where(user_1_id: partner_id)
    ).first
  end


  def validate_age?
    if birth_date.present? && (birth_date + 13.years >= Date.today)
      errors.add(:birth_date, '(you should be at least 13 years old)')
    end
  end

  def age
    dob = self.birth_date
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

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

  #friendship (grabs invite for a certain friendship.)
  #find a ay to shorten this maybe
  def friendship(friend)
    FriendRequest.where(requester_id: self.id, reciever_id: friend.id, status: true).or(FriendRequest.where(reciever_id: self.id, requester_id: friend.id, status: true)).first
  end


  #can probabyl shorten this, is repetetive

  def can_send_request
    a = FriendRequest.where(requester_id: self.id, status: false).pluck(:reciever_id)
    b = FriendRequest.where(reciever_id: self.id, status: false).pluck(:requester_id)
    User.where.not(id: [a+b+self.friends_ids+[self.id]])
  end

  def pending_invitees
    ids = FriendRequest.where(requester_id: self.id, status: false).pluck(:reciever_id)
    User.where(id: ids)
  end

  def invites_from
    ids = FriendRequest.where(reciever_id: self.id, status: false).pluck(:requester_id)
    User.where(id: ids)
  end


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      #if fb gender is something other than male/female, need to set it to :other
      user.gender = auth.extra.raw_info.gender

      if auth.extra.raw_info.birthday.nil?
        #default bday value (1st Jan, 18 years old)  if fb bday can't be retrieved
        user.birth_date = Date.strptime("#{DateTime.now.year-18}/01/01", "%Y/%m/%d")
      else
        user.birth_date = auth.extra.raw_info.birthday
      end
      # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private

  def create_profile
    Profile.create(user: self)
  end

  def create_status
    Status.create(user: self)
  end
end
