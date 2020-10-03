class Link < ApplicationRecord
  require 'base62-rb'

  BASE_URL = "http://www.url-shortener.com/"
  DEFAULT_EXPIRATION_DAYS = 30
  validates :full_url, presence: true
  validates :slug, uniqueness: true

  # Based on ID for easy find later, so needs to be after create.
  after_create do
    shorten_url
  end

  def short_link 
    BASE_URL + slug
  end

  def default_expiration
    DEFAULT_EXPIRATION_DAYS*86400
  end

  private

  def shorten_url 
    return if self.slug 

    self.slug = Base62.encode(self.id)
    self.save!
  end
end
