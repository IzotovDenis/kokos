class Item < ApplicationRecord
    belongs_to :group, optional: true
    belongs_to :brand, optional: true
    validates :title, presence: true
end
