class LinksController < ApplicationController

  def redirect
    if Link.find(Base62.decode(params[:slug]))
      redirect_to Link.find(Base62.decode(params[:slug])).full_url
    elsif
      redirect_to Link.find_by(slug: params[:slug])
    end
  end
  
  def create 
    link = Link.create!(link_params)
    REDIS.set(link.slug, link.full_url, ex: expiration_seconds|| link.default_expiration)
    
    json_response(link, :created)

    rescue StandardError
      json_response(link, 400)
  end

  def destroy 

  end

  private 

  def expiration_seconds
    if params[:expiration_days]
      return params[:expiration_days].to_i*86400
    else 
      return nil 
    end
  end 

  def link_params 
    params.permit(:full_url, :slug)
  end
end
