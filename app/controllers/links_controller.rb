class LinksController < ApplicationController
    def get 

    end 

    def create 
        @link = Link.new(link_params)
        @link.save
        @link.short = Base62.encode(@link.id)    
    end 

    def destroy 

    end 
end
