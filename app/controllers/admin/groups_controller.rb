class Admin::GroupsController < AdminController
    before_action :set_group, only: [:show, :update, :destroy]


    def index
        @groups = Group.all.index_by(&:id).as_json(:methods => [:parent_id])
        @sort = Group.select("ancestry, id, title").arrange_serializable(:order=>:title)
        @roots = Group.roots
        render json: {list: @groups, tree: @sort, roots: @roots}
    end

    def create
        @group = Group.new(group_params)
            if @group.save
                render json: {success: true, group: @group.to_json}
            else
                render json: {success: false, errors: @group.errors}
            end
    end

    def show
        render json: @group.to_json
    end

    def update
        if @group.update(group_params)
            render json: {success: true, group: @group.to_json}
        else
            render json: {success: false, errors: @group.errors}
        end
    end

    def destroy

    end

    private 

    def set_group
        @group = Group.find(params[:id])
    end

    def group_params
        params.require(:group).permit(:title, :discription, :parent_id)
    end

end
