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

module ShoppingCart
  mattr_accessor :user_class
  mattr_accessor :product_class
  mattr_accessor :product_path

  def self.user_class
    @@user_class.constantize
  end

  def self.product_class
    @@product_class.constantize
  end

end
