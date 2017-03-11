class PurchasesController < ApplicationController
    # A callback to set up an @owner object to work with 
    before_action :set_purchase, only: [:show, :edit, :update, :destroy]

    def index
        @purchases = Purchase.chronological.paginate(page: params[:page]).per_page(10)
    end

    def new
        @purchase = Purchase.new
    end

    def create
        @purchase = Purchase.new(purchase_params) #purchase.count not updating
        if @purchase.save
            #if saved to database
            flash[:notice] = "Successfully added a purchase for #{@purchase.quantity} #{@purchase.item_id.name}."
            redirect_to purchases_path
        else
            #return to the 'new' form
            render action: 'new'
        end
    end

    private
        def set_purchase
            @purchase = Purchase.find(params[:id])
        end

        def purchase_params
        params.require(:purchase).permit(:item_id, :quantity, :date) #date?
        end
end
