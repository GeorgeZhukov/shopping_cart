require "shopping_cart/engine"
require "country_select"
require "geocoder"
require "credit_card_validations"
require "state_machines"

module ShoppingCart
  mattr_accessor :user_class

  def self.user_class
    @@user_class.constantize
  end
end
