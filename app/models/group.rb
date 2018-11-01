class Group < ApplicationRecord
    has_many :items
    has_ancestry
    validates :title, presence: true
end
