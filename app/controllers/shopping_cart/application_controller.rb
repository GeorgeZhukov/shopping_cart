module ShoppingCart
  class ApplicationController < ActionController::Base

    private
    def _current_user
      instance_eval(&ShoppingCart.current_user_method)
    end
  end
end
