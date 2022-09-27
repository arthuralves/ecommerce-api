require 'rails_helper'

RSpec.describe "Admin::V1::Coupons", type: :request do
  let(:user) { create(:user) }

  context "GET /coupons" do
    let(:url) { "/admin/v1/coupons" }
    let!(:coupons) { create_list(:coupon, 5) }

    it "returns all Coupons" do
      get url, headers: auth_header(user)
      expect(body_json['coupons']).to contain_exactly *coupons.as_json(only: %i(id name code status discount_value max_use due_date))
    end

    it "returns success status" do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end
  end 

  context "POST /coupons" do
    let(:url) { "/admin/v1/coupons" }
    
    context "with valid params" do
      let(:coupons) { { coupon: attributes_for(:coupon) }.to_json }

      it 'adds a new Coupons' do
        expect do
          post url, headers: auth_header(user), params: coupons
        end.to change(Coupon, :count).by(1)
      end

      it 'returns last added Coupons' do
        post url, headers: auth_header(user), params: coupons
        expected_coupon = Coupon.last.as_json(only: %i(id name code status discount_value max_use due_date))
        expect(body_json['coupon']).to eq expected_coupon
      end

      it 'returns success status' do
        post url, headers: auth_header(user), params: coupons
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      let(:coupon_invalid_params) do 
        { coupon: attributes_for(:coupon, name: nil) }.to_json
      end

      it 'does not add a new Coupons' do
        expect do
          post url, headers: auth_header(user), params: coupon_invalid_params
        end.to_not change(Coupon, :count)
      end

      it 'returns error message' do
        post url, headers: auth_header(user), params: coupon_invalid_params
        expect(body_json['errors']['fields']).to have_key('name')
      end

      it 'returns unprocessable_entity status' do
        post url, headers: auth_header(user), params: coupon_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

end
