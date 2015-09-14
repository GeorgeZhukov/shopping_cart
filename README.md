# Shopping Cart


[![Build Status](https://travis-ci.org/GeorgeZhukov/shopping_cart.svg)](https://travis-ci.org/GeorgeZhukov/shopping_cart)


## Installation

1. Add gem to your Gemfile `gem "shopping_cart"`
2. Create shopping_cart.rb initializer

  ```
  ShoppingCart.user_class = "User"
  ShoppingCart.product_class = "Book"
  ```
3. Add `current_or_guest_user` method to `ApplicationController`.
4. Mount routes `mount ShoppingCart::Engine => '/shopping-cart', as: 'shopping_cart'`
5. Copy and install migrations `rake shopping_cart:install:migrations`
