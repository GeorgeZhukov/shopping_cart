require "shopping_cart/engine"
require "country_select"
require "geocoder"
require "credit_card_validations"
require 'state_machines-activerecord'
require "tilt/haml"
require "wicked"
require "cancan"
require "breadcrumbs_on_rails"
require "devise"
require 'active_support/concern'

module ShoppingCart
  mattr_accessor :user_class
  mattr_accessor :product_class

  def self.user_class
    @@user_class.constantize
  end

  def self.product_class
    @@product_class.constantize
  end

  def self.init
    # user_class.include(UserMixin)
    # user_class
  end

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
