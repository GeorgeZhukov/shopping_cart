ShoppingCart::Engine.routes.draw do

  resources :cart, only: [:show, :update] do
    member do
      delete 'remove-item'
      delete 'clear'
    end
  end
end
