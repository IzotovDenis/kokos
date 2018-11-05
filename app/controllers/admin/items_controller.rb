class Admin::ItemsController < AdminController
    before_action :set_item, only: [:show, :update, :destroy]

    rescue_from ActiveRecord::RecordNotFound do |exception|
        render json: {error:'item not fount'}, :status => 404 
    end

    def index
        @items = Item.where(query_params).order("title")
        render json: @items
    end

    def show
        render json: @item
    end

    def create
        @item = Item.new(item_params)
            if @item.save
                render json: {success: true, item: @item}
            else
                render json: {success: false, errors: @item.errors}
            end
    end

    def update
        if @item.update(item_params)
            render json: {success: true, item: @item}
        else
            render json: {success: false, errors: @item.errors}
        end
    end

    def destroy
        if @item.destroy
            render json: {success: true}
        else
            render json: {success: false}
        end
    end

    private 

    def query_params
        params.permit(:group_id, :brand_id)
    end

    def set_item
        @item = Item.find(params[:id])
    end

    def item_params
        params.require(:item).permit(:title, :code, :discription, :article, :subtitle, :disctiption, :brand_id, :group_id, :price, :parent_id, images: [:url, post: [:url], thumb: [:url]])
    end

end
