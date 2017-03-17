class ItemPricesController < ApplicationController
    #before_action :set_item_price, only: [:show, :edit, :update, :destroy]

    def index
        @active_items = Item.alphabetical.active.all
    end

    def new
        @item_price = ItemPrice.new
    end

    def create
        @item_price = ItemPrice.new(item_price_params)
        @item_price.start_date = Date.current
        if @item_price.save
            #if saved to database
            @item = Item.find(@item_price.item_id)
            flash[:notice] = "Changed the price of #{@item.name}."
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
