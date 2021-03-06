require 'rails_helper'

module ShoppingCart
  RSpec.describe DeliveryService, type: :model do
    context "validation" do
      it { should validate_presence_of :name }
      it { should validate_presence_of :price }
    end

    describe "#to_s" do
      it "returns name" do
        expect(subject.to_s).to eq subject.name
      end
    end
  end
end
