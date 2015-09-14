module ShoppingCart
  RSpec.describe CartHelper, type: :helper do
    describe "#compare_address" do
      it "returns positive if addresses is the same" do
        address = create :shopping_cart_address
        order = create :shopping_cart_order, shipping_address: address, billing_address: address
        expect(helper.compare_address(order, true, false)).to be_truthy
      end

      it "returns negative if addresses is NOT the same" do
        order = create :shopping_cart_order
        expect(helper.compare_address(order, true, false)).to be_falsey
      end
    end
  end
end