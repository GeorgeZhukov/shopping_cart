require_dependency "shopping_cart/application_controller"

module ShoppingCart
  class CartController < ApplicationController
    include Wicked::Wizard

    steps :intro, :address, :delivery, :payment, :confirm

    before_action :set_cart

    def show
    end

    def update
    end

    def add_product
      product = ShoppingCart.product_class_class.find(params[:id])
      if params[:add_to_cart]
        quantity = params[:add_to_cart].fetch(:quantity, 1).to_i
      else
        quantity = 1
      end
      @cart.add_product(product, quantity)
      redirect_to wizard_path(:intro)
      # redirect_to shopping_cart_path(:intro), notice: (I18n.t"books.add_to_cart.books_was_successfully_added_to_cart")
    end

    private
    def set_cart
      @cart = _current_user.cart
      # init_addresses
      # init_credit_card
    end
  end
end
