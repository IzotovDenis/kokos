class Order < ApplicationRecord
    attr_accessor :order_list
    after_initialize :set_items

    def avaiable_items
        if self.order_list
            list = []
            ids = self.order_list.keys || []
            @items = Item.where("id IN (?)", ids)
            @items.each do |item|
                pre_item = item.as_json
                pre_item['qty'] = self.order_list[item['id'].to_s]
                list.push(pre_item)
            end
            return list
        else
            []
        end
    end

    def pre_amount
        amount = 0
        self.avaiable_items.map {|item|  amount+=self.order_list[item["id"].to_s].to_i*(item['discount_price'].to_i > 0 ? item['discount_price'].to_i : item['price'].to_i )}
        amount
    end

     def set_items
        if self.new_record?
            self.items = self.avaiable_items
            self.amount = self.pre_amount
            self.items_count = self.items.count
        end
     end

end
