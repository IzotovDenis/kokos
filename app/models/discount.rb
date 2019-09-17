class Discount < ApplicationRecord
    after_save :update_prices
    def items
        Item.where(:id => self.ids)
    end

    def items_prev  
        Item.where(:id => self.ids).limit(4)
    end

    def update_prices
        DiscountEngine.set_prices
    end
end
