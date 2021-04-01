class Post < ApplicationRecord
    validates :title, presence: true, length: {minimum: 5}
    validates :body, presence: true, length: {minimum: 10}

    #post can belong to user, and belong to group (if any). if group is none, post to homepage
    belongs_to :user
    # belongs_to :club, optional: true

    has_one_attached :image

    has_many :comments, dependent: :destroy
    has_many :likes, :as => :likeable, dependent: :destroy

    #make sure a user can only like ONCE on a post
    def liked?(user)
        self.likes.find{|like| like.user_id == user.id}
    end

    #time created is..wrong??
    def date
        self.created_at.strftime("%d-%m-%Y %H:%M")
    end
end
