class Profile < ApplicationRecord
    # include ActionView::Helpers::UrlHelper
    include ActiveModel::Validations
    validates_with ImageValidator

    has_one_attached :image
    belongs_to :user

    def attached_img
        img_path = (self.image.attached?)? self.image : "default.png"
    end

end
