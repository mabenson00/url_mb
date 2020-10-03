class Link < ApplicationRecord
  require 'base62-rb'

  BASE_URL = "http://www.url-shortener.com/"
  validates :full_url, presence: true

  after_create do
    shorten_url 
  end

  def short_link 
    BASE_URL + slug
  end 

  private

  def shorten_url 
    return if self.slug 

    self.slug = Base62.encode(self.id)
    self.save!
  end
end
