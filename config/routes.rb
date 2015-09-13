ShoppingCart::Engine.routes.draw do
  root "cart#show"

  resources :cart, only: [:show, :update] do
    member do
      put 'add-product/:product_id' => "cart#add_product", as: "add_product"
      delete 'remove-item'
      delete 'clear'
    end
  end
end
