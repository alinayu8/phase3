class ItemsController < ApplicationController
    before_action :set_item, only: [:show, :edit, :update, :destroy]

    def index
        @boards = Item.active.for_category('boards').paginate(page: params[:page]).per_page(10)
        @pieces = Item.active.for_category('pieces').paginate(page: params[:page]).per_page(10)
        @clocks = Item.active.for_category('clocks').paginate(page: params[:page]).per_page(10)
        @supplies = Item.active.for_category('supplies').paginate(page: params[:page]).per_page(10)
        @inactive_items = Item.inactive.paginate(page: params[:page]).per_page(10)
    end

    def new
    end

    def create
        @item = Item.new(item_params)
        if @item.save
            #if saved to database
            flash[:notice] = "Successfully created #{@item.name}."
            redirect_to item_path(@item) #error here
        else
            #return to the 'new' form
            render action: 'new'
        end
    end

    def show
        @item = @item
        @price_history = ItemPrice.where(item_id: @item.id).map{|p| p}
        @similar_items = Item.active.for_category(@item.category).map{|i| i} - [@item]
    end

    def edit #did i do this right
        # @items = Item.active.paginate(page: params[:page]).per_page(10)
        # render action: 'edit'
    end

    def update
        if @item.update_attributes(item_params)
            flash[:notice] = "Successfully updated #{@item.name}."
            redirect_to item_path(@item)
        else
            render action: 'edit'
        end
    end

    def destroy
        @item.destroy
        flash[:notice] = "Successfully removed #{@item.name} from the system."
        redirect_to items_path
    end

    private
        def set_item
            @item = Item.find(params[:id])
        end

        def item_params
            params.require(:item).permit(:name, :description, :color, :category, :weight, :inventory_level, :reorder_level, :active)
        end
end
