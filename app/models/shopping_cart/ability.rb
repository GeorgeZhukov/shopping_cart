module ShoppingCart
  class Ability
    include ::CanCan::Ability

    def initialize(user)
      if user.is_admin
        can :manage, :all
      else
        can :read, DeliveryService
        can :read, Order, user_id: user.id

        unless user.guest
          can :read, Address, user_id: user.id
        end
      end

    end
  end

end
