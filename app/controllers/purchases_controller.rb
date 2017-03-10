class PurchasesController < ApplicationController
    # A callback to set up an @owner object to work with 
    before_action :set_purchase, only: [:show, :edit, :update, :destroy]

    def index
    end

    def new
        @purchase = Purchase.new
    end

    def create
    end
end
