class Link < ApplicationRecord
    BASE_URL = "http://www.url-shortener.com/"
    
    def full_url 
        BASE_URL + slug
    end 
end
