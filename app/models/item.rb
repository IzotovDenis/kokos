class Item < ApplicationRecord
    belongs_to :group, optional: true
    belongs_to :brand, optional: true
end
