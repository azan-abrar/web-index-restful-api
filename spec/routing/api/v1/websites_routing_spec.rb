require "rails_helper"

RSpec.describe Api::V1::WebsitesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/v1/websites").to route_to("api/v1/websites#index")
    end

    it "routes to #parse" do
      expect(:get => "/api/v1/websites/parse").to route_to("api/v1/websites#parse")
    end
  end
end
