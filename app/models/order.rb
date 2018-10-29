class Order < ApplicationRecord
    attr_accessor :order_list
    after_initialize :set_items

    def avaiable_items
        if self.order_list
            ids = self.order_list.keys || []
            @items = Item.where("id IN (?)", ids)
        else
            []
        end
    end

    def pre_amount
        amount = 0
        self.avaiable_items.map {|item| amount+=item['ordered'].to_i*item['price'].to_i}
        amount
    end

    def unavaiable_items
        if self.order_list
            ids = self.order_list.keys  || []
            @items = Item.where("id IN (?)", ids)
        else
            []
        end
    end

    def is_valid?
        self.avaiable_items.length > 0
    end

     def set_items
        if self.new_record?
            self.items = self.avaiable_items
            self.amount = self.pre_amount
            self.items_count = self.items.count
        end
     end

end
