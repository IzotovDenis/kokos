class Brand < ApplicationRecord
    mount_uploader :image, BrandUploader
    default_scope { order(title: :desc) }
    has_many :items, dependent: :nullify
end
