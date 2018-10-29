class ItemImage < ApplicationRecord
    mount_uploader :file, ItemImageUploader
end
