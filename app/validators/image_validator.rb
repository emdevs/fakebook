class ImageValidator < ActiveModel::Validator
    def validate(record)
        if record.image.attached?
            unless record.image.byte_size <= 1.megabyte
                record.errors.add :image, "is too big"
            end

            acceptable_types = ["image/jpeg", "image/png"]
            unless acceptable_types.include?(record.image.content_type)
                record.errors.add :image, "must be a JPEG or PNG"
            end
        end
    end
end