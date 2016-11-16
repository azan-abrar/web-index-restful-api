require 'rails_helper'

RSpec.describe "Websites", type: :request do
  describe "GET /websites" do
    it "works! (now write some real specs)" do
      get api_v1_websites_path
      expect(response).to have_http_status(200)
    end
  end
end
