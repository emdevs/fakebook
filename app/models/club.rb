class Club < ApplicationRecord

    include ActiveModel::Validations
    validates_with ImageValidator
    
    validates :owner_id, presence: true
    validates :name, presence: true, length: {minimum: 5}
    validates :description, presence: true, length: {minimum: 10}

    #between 10 and 50 members, defines the maximum amount of members allowed in club (no minimum)
    validates :capacity, presence: true, numericality: {
        greater_than_or_equal_to: 10,
        less_than_or_equal_to: 50
    }

    #after created,
    after_create :create_chatroom

    #whenever club is saved, this will run (need to check sometime that this is working)
    validate :member_count_less_than_capacity, on: :edit

    belongs_to :owner, class_name: "User"

    #club image
    has_one_attached :image

    has_many :memberships, dependent: :destroy
    has_many :members, through: :memberships
    has_many :posts, as: :postable, dependent: :destroy

    has_one :chatroom, dependent: :destroy

    #Club Methods
    def unblocked_members
        unblocked_ids = Membership.where(club_id: self.id, blocked: false).pluck(:member_id)
        User.where(id: unblocked_ids)
    end

    def blocked_members
        blocked_ids = Membership.where(club_id: self.id, blocked: true).pluck(:member_id)
        User.where(id: blocked_ids)
    end

    def member_count
        #only count unblocked members
        self.unblocked_members.count
    end

    def member?(user_id)
        bool = (self.memberships.find_by(member_id: user_id))? true : false
    end

    def background_img
        img_path = (self.image.attached?)? self.image : "club_default.jpg"
    end

    private

    #ONLY RUN THIS IF EDITING CLUB!
    def member_count_less_than_capacity
        if (self.capacity).is_a?(Integer) && self.member_count > self.capacity 
            errors.add(:capacity, "Capacity cannot be lower than the total number of current members.")
        end
    end

    def create_chatroom
        Chatroom.create(club: self)
    end
end
