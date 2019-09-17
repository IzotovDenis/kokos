class DiscountEngine
    class << self
        def set_prices
            basic_discount = Discount.where(all_items: true).first
            Item.find_each do |item|
                item.prev_price = item.price
                item.price = item.price * 0.8
                item.save
            end
        end
    end
   end