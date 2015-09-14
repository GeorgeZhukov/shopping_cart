require 'rails_helper'

module ShoppingCart
  RSpec.describe Order, type: :model do
    subject { create :shopping_cart_order, delivery_service: nil }
    let(:book) { create :book }

    it { should belong_to :billing_address }
    it { should belong_to :shipping_address }
    it { should belong_to :credit_card }
    it { should belong_to :user }
    it { should belong_to :delivery_service }
    it { should validate_presence_of :user }
    it { should have_many :order_items }

    it "generates number" do
      expect(subject.number).not_to be_nil
    end

    it "init total_price" do
      expect(subject.total_price).not_to be_nil
    end

    describe "#merge" do
      let(:order1) { create :shopping_cart_order }
      let(:order2) { create :shopping_cart_order }
      let(:book1) { create :book }
      let(:book2) { create :book }

      it "calls #move_items_to if no same books" do
        order1.add_product book1
        order2.add_product book2
        expect(order1).to receive(:move_items_to).once
        order2.merge(order1)
      end

      it "calls #add_product for every item if there are same books" do
        order1.add_product book1
        order2.add_product book1
        expect(order2).to receive(:add_product).with(book1, 1).once
        order2.merge(order1)
      end
    end

    describe "#move_items_to" do
      let(:another_order) { create :shopping_cart_order }
      it "moves orders item from one orders to another" do
        subject.add_product book
        subject.move_items_to another_order
        should be_empty
        expect(another_order).not_to be_empty
      end

      it "moves few orders items from one orders to another" do
        5.times { subject.add_product create(:book) }
        subject.move_items_to another_order
        should be_empty
        expect(another_order.order_items.count).to eq 5
      end

      it "updates total price" do
        subject.add_product book
        expect { subject.move_items_to another_order }.to change{another_order.total_price}.by(book.price)
      end
    end

    describe "#add_product" do

      it "creates orders item with given book and sets quantity to one by default" do
        subject.add_product book
        order_item = OrderItem.first
        expect(order_item.product).to eq book
        expect(order_item.quantity).to eq 1
      end

      it "increase quantity by one when same book added" do
        subject.add_product book
        subject.add_product book
        order_item = OrderItem.first
        expect(order_item.quantity).to eq 2
      end

      context "total price" do
        before do
          subject.clear
        end

        it "updates to book price" do
          subject.add_product book
          expect(subject.total_price).to eq book.price
        end

        it "updates to 2x book price" do
          subject.add_product(book, 2)
          expect(subject.total_price).to eq book.price * 2
        end

        it "updates with 2 different books" do
          book2 = create :book
          subject.add_product book
          subject.add_product book2
          expect(subject.total_price).to eq book.price + book2.price
        end
      end
    end

    describe "#books_count" do
      it "returns zero if no orders items" do
        expect(subject.products_count).to eq 0
      end

      it "returns 1 if one orders item with quantity eq to 1" do
        subject.order_items << create(:shopping_cart_order_item, quantity: 1)
        expect(subject.products_count).to eq 1
      end

      it "returns 2 if one orders item with quantity eq to 2" do
        subject.order_items << create(:shopping_cart_order_item, quantity: 2)
        expect(subject.products_count).to eq 2
      end

      it "returns 8 if one orders item with quantity eq to 3 and second eq to 5" do
        subject.order_items << create(:shopping_cart_order_item, quantity: 3)
        subject.order_items << create(:shopping_cart_order_item, quantity: 5)
        expect(subject.products_count).to eq 8
      end
    end

    describe "#empty?" do

      it "returns true when no orders items" do
        should be_empty
      end

      it "returns false when has some orders items" do
        subject.add_product create(:book)
        expect(subject).not_to be_empty
      end
    end

    describe "#clear" do
      before do
        book = create :book
        delivery_service = create :shopping_cart_delivery_service
        billing_address = create :shopping_cart_address
        shipping_address = create :shopping_cart_address

        subject.add_product book
        subject.delivery_service = delivery_service
        subject.billing_address=billing_address
        subject.shipping_address=shipping_address
        subject.clear
      end

      it "removes orders items" do
        should be_empty
      end

      # it "removes shipping address" do
      #   expect(subject.shipping_address).to be_nil
      # end
      #
      # it "removes billing address" do
      #   expect(subject.billing_address).to be_nil
      # end

      it "removes delivery service" do
        expect(subject.delivery_service).to be_nil
      end

      it "updates total price to 0" do
        expect(subject.total_price).to be_zero
      end
    end

    describe "#notify_user" do
      xit "sends an email" do
        expect { subject.send(:notify_user) }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it "updates completed_date" do
        expect { subject.send(:notify_user) }.to change { subject.completed_date }.from(nil)
      end
    end

    describe "#take_books" do
      it "decrease books quantity by one when one item in orders with quantity eq to 1" do
        subject.add_product book
        subject.take_products
        expect {book.reload}.to change { book.in_stock }.by(-1)
      end
    end

    describe "#restore_products" do
      it "increase books quantity by one when one item in orders with quantity eq to 1" do
        subject.add_product book
        subject.restore_products
        expect {book.reload}.to change { book.in_stock }.by(1)
      end
    end

    describe "#calculate_total_price" do
      it "returns .calculate_books_price when no delivery service"
      it "returns sum of .calculate_books_price and delivery service price"
    end

    describe "#calculate_books_price" do
      it "returns 0 when no books"
      it "returns price of one book multiple by quantity"
      it "returns a sum of prices of different books multiply by quantity"
    end

    describe "#generate_number" do
      it "generates number in format 'R000000000'"
    end

    describe "#title" do
      it "returns .to_s" do
        expect(subject.title).to eq subject.to_s
      end
    end

    describe "#to_s" do
      it "returns Order #(number)" do
        expect(subject.to_s).to eq "Order ##{subject.number}"
      end
    end
  end
end
