class Profile < ApplicationRecord
    #attach profile pic
    # before_create :image_nil?
    include ActionView::Helpers::UrlHelper

    has_one_attached :profile_pic
    belongs_to :user


    def attached_img
        img_path = (self.profile_pic.attached?)? self.profile_pic : "default.png"
    end

end
