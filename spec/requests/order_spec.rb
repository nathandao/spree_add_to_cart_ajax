require 'spec_helper'

describe 'Orders' do
  context "ajax add to cart" do
    before do
      create(:product, :name => 'Ajax Rails Mug', :price => 5.0)
      visit spree.root_path
    end

    it 'should use ajax for add to cart button', :js => true do
      click_link 'Ajax Rails Mug'
      click_button 'Add To Cart'
      expect(find('#link-to-cart a .amount').text).to eq("$5.00")
    end
  end
end