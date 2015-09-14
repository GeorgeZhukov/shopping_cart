module ShoppingCart
  class ApplicationController < ::ApplicationController
    before_action :merge_abilities

    layout "shopping_cart/application"

    private

    def merge_abilities
      current_ability.merge(ShoppingCart::Ability.new(current_or_guest_user))
    end

  end
end
