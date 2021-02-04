class Post < ApplicationRecord
    validates :title, presence: true, length: {minimum: 5}
    validates :body, presence: true, length: {minimum: 10}

    belongs_to :user

    has_many :comments
    has_many :likes, dependent: :destroy

    #make sure a user can only like ONCE on a post
    def liked?(user)
        self.likes.find{|like| like.user_id == user.id}
    end
end
