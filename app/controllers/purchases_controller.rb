class PurchasesController < ApplicationController
    # A callback to set up an @purchase object to work with 
    #before_action :set_purchase, only: [:show, :edit, :update, :destroy]

    def index
        @purchases = Purchase.all.chronological.paginate(page: params[:page]).per_page(10)
    end

    def new
    end

    def create
        @purchase = Purchase.new(purchase_params)
        @purchase.date = Date.current
        if @purchase.save
            #if saved to database
            flash[:notice] = "Successfully added a purchase for #{@purchase.quantity} #{Item.find(@purchase.item_id).name}."
            redirect_to purchases_path
        else
            #return to the 'new' form
            render action: 'new'
        end
    end

    private
        # def set_purchase
        #     @purchase = Purchase.find(params[:id])
        # end

        def purchase_params
            params.require(:purchase).permit(:item_id, :quantity, :date)
        end
end
