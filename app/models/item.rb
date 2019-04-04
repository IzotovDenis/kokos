class Item < ApplicationRecord
    belongs_to :group, optional: true
    belongs_to :brand, optional: true
    attr_accessor :ordered
    validates :title, presence: true
end
