class V1::DiscountsController < V1Controller
    before_action :set_discount, only: [:show]

    def index
        discounts = Discount.where(:active=>true, :all_items=>false).as_json(methods: :items_prev)
        global = Discount.where(:active=>true, :all_items=>true).first
        render json: {discounts: discounts, global: global}
    end

    def show
        render json: {discount: @discount.as_json(methods: :items)}
    end


    def set_discount
        @discount = Discount.find(params[:id])
    end
end