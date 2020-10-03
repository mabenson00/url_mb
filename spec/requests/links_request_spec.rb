require 'rails_helper'
require 'base62-rb'
RSpec.describe "Links", type: :request do
  let(:http_request) { post links_path(link_params)}
  let(:link_params) { { full_url: link, slug: slug } }
  before { http_request }

  context "with link and slug" do 
    let(:link) { "http://www.espn.com" }
    let(:slug) { "espn" }

    it "is created and returns correct info" do 
      expect(json["id"]).to be_instance_of(Integer)
      expect(json["slug"]).to eq(slug)
      expect(response).to have_http_status(:created)
    end
  end

  context "with link, no slug" do 
    let(:link) {"http://www.espn.com"}
    let(:slug) { nil }

    it "is created and returns correct info" do 
      expect(json["id"]).to be_instance_of(Integer)
      expect(json["slug"]).to eq(Base62.encode(json["id"]))
      expect(response).to have_http_status(:created)
    end
  end
end
