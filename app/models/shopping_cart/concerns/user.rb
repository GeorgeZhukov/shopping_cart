module ShoppingCart
  module UserMixin
    extend ActiveSupport::Concern

    included do
      has_many :addresses, class_name: "ShoppingCart::Address"
      has_many :orders, class_name: "ShoppingCart::Order"

      belongs_to :billing_address, class_name: "ShoppingCart::Address"
      belongs_to :shipping_address, class_name: "ShoppingCart::Address"
    end

    def cart
      orders.in_progress.first_or_create
    end

    def reassign_data_to(user)
      move_orders_to user
      move_addresses_to user
    end

    def move_orders_to(user)
      # Move current cart
      user.cart.merge(cart)

      # Move other orders
      o = orders.where.not(state: "in_progress")
      o.update_all(user_id: user.id) if o.exists?
    end

    def move_addresses_to(user)
      a = user.addresses
      a.update_all(user_id: user.id) if a.exists?
    end

  end
end