require_dependency "shopping_cart/application_controller"

module ShoppingCart
  class CartController < ApplicationController
    include Wicked::Wizard

    steps :intro, :address, :delivery, :payment, :confirm

    before_action :set_cart

    def show
      jump_to(:intro) if @cart.empty? and step != :intro
      case step
        when :delivery
          init_delivery
        when :confirm
          check_cart
      end
      render_wizard
    end

    def update
      case step
        when :intro
          update_cart
          return render_wizard unless params[:checkout]
        when :address
          return render_wizard unless update_addresses
        when :delivery
          return redirect_to :back, notice: (I18n.t"cart.delivery.check_delivery") unless update_delivery_service
        when :payment
          return render_wizard unless update_credit_card
        when :confirm
          check_cart
          @cart.checkout!
          return redirect_to order_path(@cart)
      end
      render_wizard @cart
    end

    def remove_item
      order_item = @cart.order_items.find params[:item_id]
      order_item.destroy
      if @cart.empty?
        @cart.clear
      end
      redirect_to wizard_path(:intro)
    end

    def add_product
      product = ShoppingCart.product_class.find(params[:product_id])
      if params[:add_to_cart]
        quantity = params[:add_to_cart].fetch(:quantity, 1).to_i
      else
        quantity = 1
      end
      @cart.add_product(product, quantity)
      redirect_to wizard_path(:intro)
      # redirect_to shopping_cart_path(:intro), notice: (I18n.t"books.add_to_cart.books_was_successfully_added_to_cart")
    end

    def clear
      @cart.clear
      redirect_to wizard_path(:intro), notice: (I18n.t"cart.clear.cart_is_cleared")
    end

    private

    def update_cart
      params[:items].each do |item|
        order_item = @cart.order_items.find(item[:id])
        order_item.update(quantity: item[:quantity])
      end
    end

    def set_cart
      @cart = current_cart
      init_addresses
      init_credit_card
    end

    def check_cart
      jump_to(:address) unless @cart.shipping_address and @cart.billing_address
      jump_to(:delivery) unless @cart.delivery_service
      jump_to(:payment) unless @cart.credit_card
    end

    def init_addresses
      if current_user
        @cart.shipping_address ||= current_user.shipping_address.dup if current_user.shipping_address
        @cart.billing_address ||= current_user.billing_address.dup if current_user.billing_address
      end
      @cart.shipping_address ||= Address.new(user: current_or_guest_user)
      @cart.billing_address ||= Address.new(user: current_or_guest_user)
    end

    def init_delivery
      @delivery_services = DeliveryService.all
      @cart.delivery_service ||= @delivery_services[0]
    end

    def init_credit_card
      @cart.credit_card ||= CreditCard.new(user: current_or_guest_user)
    end

    def update_delivery_service
      @cart.delivery_service = DeliveryService.find_by_id(params[:delivery])
    end

    def update_credit_card
      @cart.credit_card ||= CreditCard.new(user: current_or_guest_user)
      @cart.credit_card.update credit_card_params
    end

    def update_addresses
      init_addresses
      is_billing_updated = @cart.billing_address.update address_params(:billing_address)

      if params[:use_billing_address] == "yes"
        is_shipping_updated = @cart.shipping_address.update address_params(:billing_address)
      else
        is_shipping_updated = @cart.shipping_address.update address_params(:shipping_address)
      end

      # Update user address
      if current_user
        # todo: maybe run this code when confirm shopping cart
        current_user.shipping_address ||= @cart.shipping_address
        current_user.billing_address ||= @cart.billing_address
        current_user.save
      end

      is_shipping_updated && is_billing_updated
    end



    def credit_card_params
      params.require(:credit_card).permit(:number, :CVV, :expiration_month, :expiration_year, :first_name, :last_name)
    end

    def address_params(type)
      params.require(type).permit(:address, :zip_code, :phone, :city, :country)
    end
  end
end
