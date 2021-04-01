class Club < ApplicationRecord
    validates :owner_id, presence: true
    validates :name, presence: true, length: {minimum: 5}
    validates :description, presence: true, length: {minimum: 10}

    #between 10 and 50 members, defines the maximum amount of members allowed in club (no minimum)
    validates :capacity, presence: true, numericality: {
        only_integer: true,
        greater_than_or_equal_to: 10,
        less_than_or_equal_to: 50
    }

    #whenever club is saved, this will run (need to check sometime that this is working)
    validate :member_count_less_than_capacity

    belongs_to :owner, class_name: "User"

    has_many :memberships
    has_many :members, through: :memberships
    # has_many :posts

    #find a way to add posting ability to clubs.

    #Club Methods
    def member_count
        self.members.count
    end

    def member?(user_id)
        bool = (self.memberships.find_by(member_id: user_id))? true : false
    end

    private

    def member_count_less_than_capacity
        if (self.capacity).is_a?(Integer) && self.members.count > self.capacity 
            errors.add(:capacity, "Capacity cannot be lower than the total number of current members.")
        end
    end
end
