class HomeController < ApplicationController
    def home
        # finding all the active items that need to be reordered and paginating that list (will_paginate)
        @items_to_reorder = Item.active.alphabetical.need_reorder
    end

    def about
    end

    def contact
    end

    def privacy
    end
end
