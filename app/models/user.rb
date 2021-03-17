class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook]

  validates :name, length: {minimum: 2}
  validates :birth_date, presence: true, if: :validate_age?
  # validates :gender, presence: true (FB signup will fail since cannot retrieve gender (for now, it returns nil))
  after_create :create_profile

  enum gender: [:male, :female, :other]
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :profile, dependent: :destroy

  #Friend Requests (true = accepted, false = pending, rejected means request is auto-deleted)
  has_many :sent_friend_requests, foreign_key: "requester_id", class_name: "FriendRequest"
  has_many :pending_friend_requests, foreign_key: "reciever_id", class_name: "FriendRequest"


  def validate_age?
    if birth_date.present? && (birth_date + 13.years >= Date.today)
      errors.add(:birth_date, 'You should be at least 13 years old.')
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

  # def self.from_omniauth(auth)
  #   where(email: auth.info.email).first_or_initialize.tap do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0,20]
  #     user.name = auth.info.name
  #     # user.gender = auth.extra.raw_info.gender
  #     # user.profile_pic = auth.info.image
  #     user.save
  #   end
  # end
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
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
end
