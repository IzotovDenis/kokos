class DiscountEngine
    class << self
        def set_prices
            basic_discount = Discount.where(all_items: true, active: true).first
            if basic_discount
                puts "found"
                Item.find_each do |item|
                    if (basic_discount.value['type'] == 'fixes')
                        puts "wrong"
                        item.discount_price = basic_discount.value['val']
                        item.save
                    end
                    if (basic_discount.value['type'] == 'percent')
                        puts "here"
                        puts basic_discount.value['val']
                        item.discount_price = item.price*(100-basic_discount.value['val'])/100.00
                        puts item.price
                        puts item.discount_price
                        item.save
                    end
                end
            else
                Item.update_all(:discount_price => 0)
            end
            items_discounts = Discount.where(all_items: false, active: true)
            items_discounts.each do |discount|
                Item.where(:id=>discount.ids).find_each do |item|
                    if (discount.value['type'] == 'fixes')
                        item.discount_price = discount.value['val']
                        item.save
                    end
                    if (discount.value['type'] == 'percent')
                        item.discount_price = item.price*(100-discount.value['val'])/100
                        item.save
                    end
                end
            end
        end
    end
   end