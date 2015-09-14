require 'rails_helper'

module ShoppingCart
  RSpec.describe OrderItem, type: :model do
    let(:book) { create :book }
    subject { create :shopping_cart_order_item, product: book }

    it { should belong_to :product }
    it { should belong_to :order }

    context "validation" do
      it { should validate_presence_of :quantity }
      # it { should validate_presence_of :orders }
      it { should validate_presence_of :product }
    end

    describe "#price" do
      it "returns correct price" do
        expect(subject.price).to eq subject.product_price * subject.quantity
      end
    end


    describe "#to_s" do
      it "returns book name with quantity" do
        expect(subject.to_s).to eq "#{book.title} x#{subject.quantity}"
      end
    end
  end
end
