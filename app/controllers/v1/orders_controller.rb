class V1::OrdersController <  V1Controller
    before_action :set_order, :only => [:show, :set_formed, :pay]
    before_action :set_active, only: [:getActive]
    before_action :prepare_order, only: [:getOrderItems, :create]


    def show
        if @order
            render json: @order
        else
            render json: { err: 'not found' }
        end
    end

    def create
        if @order.save
            OrderMailer.order(@order).deliver!
            render json: {order: @order, success: true}
        else
            render json: {success: false, errors: @order.errors}
        end
    end

    def getOrderItems
        render :json => {items: @order.avaiable_items, amount: @order.pre_amount}
    end

    private

    def set_order
        @order = Order.find(params[:id])
    end

    def getActive
        @active_order = Order.where(:user_id=> current_user)
    end

    def order_items
        keys = order_list.keys
        Item.where("id IN (?)", keys)
    end

    def order_list
        params[:order][:items]
    end

    def prepare_order
        @order = Order.new(:order_list=>params[:items], :info=>params[:info], :comment=>params[:comment])
    end
    
end