module ShoppingCart
  module ControllerMacros
    def login_admin
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        @admin = create(:admin)
        sign_in :user, @admin # sign_in(scope, resource)
      end
    end

    def login_user
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = create(:user)
        sign_in @user
      end
    end

    def can_manage_all
      before(:each) do
        @ability = Object.new
        @ability.extend(CanCan::Ability)
        allow(@controller).to receive(:current_ability).and_return(@ability)
        @ability.can :manage, :all
      end
    end
  end
end