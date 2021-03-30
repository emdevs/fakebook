class Profile < ApplicationRecord
    #attach profile pic
    # before_create :image_nil?
    include ActionView::Helpers::UrlHelper

    has_one_attached :profile_pic
    belongs_to :user


    def attached_img
        img_path = (self.profile_pic.attached?)? self.profile_pic : "default.png"
    end

    private

    # def image_nil?
    #     if !(self.profile_pic)
    #         self.profile_pic.attach(io: File.open('app/assets/images/default.png'), filename: 'default.png', content_type: 'image/png')
    #     end
    # end
end
