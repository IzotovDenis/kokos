class Admin::OrdersController < AdminController
    before_action :set_order, only: [:show, :update, :destroy]

    rescue_from ActiveRecord::RecordNotFound do |exception|
        render json: {error:'order not fount'}, :status => 404 
    end

    def index
        @orders = Order.all.order("created_at DESC")
        render json: { orders: @orders }
    end

    def show
        render json: {order: @order}
    end

    private 

    def set_order
        @order = Order.find(params[:id])
    end

end
