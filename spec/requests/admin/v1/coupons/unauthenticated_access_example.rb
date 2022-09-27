require 'rails_helper'

RSpec.describe "Admin V1 Coupons without authentication", type: :request do

  context "GET /coupons" do
    let(:url) { "/admin/v1/coupons" }
    let!(:coupons) { create_list(:coupons, 5) }

    before(:each) { get url }
    include_examples "unauthenticated access"
  end
  
  context "POST /coupons" do
    let(:url) { "/admin/v1/coupons" }

    before(:each) { get url }
    include_examples "unauthenticated access"
  end
  
  context "PATCH /coupons/:id" do
    let(:coupons) { create(:coupons) }
    let(:url) { "/admin/v1/coupons/#{coupons.id}" }

    before(:each) { get url }
    include_examples "unauthenticated access"
  end
  
  context "DELETE /coupons/:id" do
    let!(:coupons) { create(:coupons) }
    let(:url) { "/admin/v1/coupons/#{coupons.id}" } 

    before(:each) { get url }
    include_examples "unauthenticated access"
  end
end