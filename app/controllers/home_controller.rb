class HomeController < ApplicationController
    def home
        # finding all the active items that need to be reordered and paginating that list (will_paginate)
        @items_to_reorder = Item.active.need_reorder.paginate(page: params[:page]).per_page(10)
    end

#this is correct
    def about
    end

    def contact
    end

    def privacy
    end
#
end
