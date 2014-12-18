require 'spec_helper'

describe Spree::OrdersController, :type => :controller do
  let(:user) { create(:user) }

  context "Order model mock" do
    let(:order) do
      Spree::Order.create
    end

    before do
      allow(controller).to receive_messages(:try_spree_current_user => user)
    end

    context "#populate" do
      it "should create a new order when none specified upon ajax call" do
        spree_post :populate, :format => :js
        expect(cookies.signed[:guest_token]).not_to be_blank
        expect(Spree::Order.find_by_guest_token(cookies.signed[:guest_token])).to be_persisted
      end

      context "with Variant" do
        let(:populator) { double('OrderPopulator') }
        before do
          expect(Spree::OrderPopulator).to receive(:new).and_return(populator)
        end

        it "should handle ajax population" do
          expect(populator).to receive(:populate).with("2", "5", nil).and_return(true)
          spree_post :populate, { :order_id => 1, :variant_id => 2, :quantity => 5 }, { :format => :js }
          expect(response.code).to eq("302")
        end
      end
    end
  end
end