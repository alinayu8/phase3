class ItemPricesController < ApplicationController
    #before_action :set_item_price, only: [:show, :edit, :update, :destroy]

    def index
        @active_items = Item.active.paginate(page: params[:page]).per_page(10)
    end

    def new
    end

    def create
        @item_price = ItemPrice.new(item_price_params)
        if @item_price.save
            #if saved to database
            @item = Item.find(@item_price.item_id)
            flash[:notice] = "Changed the price of #{Item.find(@item_price.item_id).name}."
            redirect_to item_path(@item)
        else
            #return to the 'new' form
            render action: 'new'
        end
    end

    private
        # def set_item_price
        #     @item_price = ItemPrice.find(params[:id])
        # end

        def item_price_params
            params.require(:item_price).permit(:item_id, :price, :start_date)
        end
end
