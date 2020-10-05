require 'rails_helper'
require 'base62-rb'

RSpec.describe "Links", type: :request do
  
  describe "create" do 
    let(:http_request) { post links_path(link_params)}
    let(:link_params) { { full_url: link, slug: slug, expiration_days: expiration_days} }

    # default is no specified expiration
    let(:expiration_days) { nil }

    before { http_request }

    context "with link and slug, expiration days" do 
      let(:link) { "http://www.espn.com" }
      let(:slug) { "espn" }
      let(:expiration_days) { 45 }

      it "is created and returns correct information" do 
        expect(json["id"]).to be_instance_of(Integer)
        expect(json["slug"]).to eq(slug)
        expect(response).to have_http_status(:created)
      end

      it "creates returns correct info from redis" do 
        expect(REDIS.get(slug)).to eq(link)
        expect(REDIS.TTL(slug)).to eq(45*86400)
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

      it "returns default redis expiration time" do 
        expect(REDIS.TTL(json["slug"])).to eq(30*86400)
      end
    end

    context "with link, no slug" do 
      let(:link) { nil }
      let(:slug) { nil }

      it "returns an error" do 
        expect(response).to have_http_status(400)
      end
    end

    context "with duplicate slug" do 
      let(:link) { "http://www.example.com" }
      let(:slug) { "espn" }

      # make a second request, so the record was already created
      before { post links_path(link_params) }

      it "returns an error" do 
        expect(response).to have_http_status(400)
      end
    end

    describe "redirect" do
      let(:link) { "http://www.espn.com" }
      let(:slug) { "espn" }
      let(:expiration_days) { 45 }
      let(:create_request) { post links_path(link_params)}
      let(:link_params) { { full_url: link, slug: slug, expiration_days: expiration_days} }
      let(:redirect_request) { get redirect_path("espn") }

      it "redirects" do 
        create_request
        expect(redirect_request).to redirect_to(link)
      end

      context "when link not found" do 
        let(:redirect_request) { get redirect_path("not_found") } 

        it "responds with error" do 
          redirect_request
          expect(response).to have_http_status(404)
        end
      end
    end
  end
end
