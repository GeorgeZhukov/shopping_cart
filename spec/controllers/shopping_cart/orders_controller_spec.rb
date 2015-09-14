require 'rails_helper'

module ShoppingCart
  RSpec.xdescribe OrdersController, type: :controller do
    can_manage_all
    login_user

    let(:order) { create :shopping_cart_order, user: @user }

    describe "GET index" do
      before { get :index }

      it "assigns @orders" do
        expect(assigns(:orders)).to match_array [order]
      end

      it "renders the index template" do
        expect(response).to render_template("index")
      end

      context "cancan doesn't allow index" do
        before do
          @ability.cannot :read, Order
          get :index
        end

        it { expect(response).to be_forbidden }
      end
    end

    describe "GET show" do
      before { get :show, id: order.id }

      it "assigns @order" do
        expect(assigns(:order)).to eq order
      end

      it "renders the show template" do
        expect(response).to render_template("show")
      end

      context "cancan doesn't allow show" do
        before do
          @ability.cannot :read, Order
          get :show, id: order.id
        end

        it { expect(response).to be_forbidden }
      end
    end
  end
end
