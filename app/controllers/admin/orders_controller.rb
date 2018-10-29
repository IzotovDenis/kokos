class Admin::OrdersController < AdminController
    before_action :set_order, only: [:show, :update, :destroy]

    rescue_from ActiveRecord::RecordNotFound do |exception|
        render json: {error:'order not fount'}, :status => 404 
    end

    def index
        @orders = Order.all
        render json: @orders
    end

    def show
        render json: @order
    end

    private 

    def set_order
        @order = Order.find(params[:id])
    end

end
