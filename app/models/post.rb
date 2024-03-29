class Post < ApplicationRecord
    
    include ActiveModel::Validations
    validates_with ImageValidator

    validates :title, presence: true, length: {minimum: 5}
    validates :body, presence: true, length: {minimum: 10}

    belongs_to :user
    #make post polymorphic! (can belong to either wall or club)
    belongs_to :postable, polymorphic: true

    has_one_attached :image

    has_many :comments, dependent: :destroy
    has_many :likes, :as => :likeable, dependent: :destroy

    #make sure a user can only like ONCE on a post
    def liked?(user)
        self.likes.find{|like| like.user_id == user.id}
    end

    def date
        self.created_at.strftime("%d-%m-%Y %H:%M")
    end
end
