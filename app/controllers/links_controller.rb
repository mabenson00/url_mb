class LinksController < ApplicationController
  def create 
    @link = Link.create!(link_params)
    json_response(@link, :created)
  end

  def destroy 

  end

  private 

  def link_params 
    params.permit(:full_url, :slug)
  end
end
