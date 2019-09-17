class Admin::DiscountsController < AdminController
    before_action :set_discount, only: [:show, :update, :destroy]

    rescue_from ActiveRecord::RecordNotFound do |exception|
        render json: {error:'discount not fount'}, :status => 404 
    end

    def index
        @discounts = Discount.all.order(:created_at)
        render json: {discounts: @discounts}
    end

    def show
        render json: {discount: @discount, items: @discount.items }
    end

    def create
        @discount = Discount.new(discount_params)
            if @discount.save
                render json: {success: true, discount: @discount}
            else
                render json: {success: false, errors: @discount.errors}
            end
    end

    def update
        if @discount.update(discount_params)
            render json: {success: true, discount: @discount}
        else
            render json: {success: false, errors: @discount.errors}
        end
    end

    def destroy
        if @discount.destroy
            render json: {success: true}
        else
            render json: {success: false}
        end
    end

    private 

    def query_params
        params.permit(:group_id, :brand_id)
    end

    def set_discount
        @discount = Discount.find(params[:id])
    end

    def discount_params
        params.require(:discount).permit(:title, :text, :active, :all_items, value: [:type, :val], ids: [])
    end

end
