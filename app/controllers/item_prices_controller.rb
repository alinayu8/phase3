class ItemPricesController < ApplicationController
    before_action :set_item_price, only: [:show, :edit, :update, :destroy]

     private
        def set_item_price
            @item_price = ItemPrice.find(params[:id])
        end

        def item_price_params
        params.require(:item_price).permit(:item_id, :price, :start_date)
        end
end
