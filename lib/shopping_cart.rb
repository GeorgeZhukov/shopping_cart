require "shopping_cart/engine"
require "country_select"
require "geocoder"
require "credit_card_validations"
require 'state_machines-activerecord'

module ShoppingCart
  mattr_accessor :user_class
  mattr_accessor :product_class

  def self.user_class
    @@user_class.constantize
  end

  def self.product_class
    @@product_class.constantize
  end

  def self.current_user_method(&block)
    @current_user = block if block
    # todo: raise
    @current_user
  end

end
