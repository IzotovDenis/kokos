class Item < ApplicationRecord
    belongs_to :group, optional: true
    belongs_to :brand, optional: true
    attr_accessor :ordered
    validates :title, presence: true

    def with_discount
        basic_discount = Discount.where(all_items: true).first
        self.discount_price = self.price * 0.8
        self
    end
end
