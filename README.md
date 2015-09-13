# Shopping Cart


[![Build Status](https://travis-ci.org/GeorgeZhukov/shopping_cart.svg)](https://travis-ci.org/GeorgeZhukov/shopping_cart)
[![Code Climate](https://codeclimate.com/github/GeorgeZhukov/shopping_cart/badges/gpa.svg)](https://codeclimate.com/github/GeorgeZhukov/shopping_cart)
[![Test Coverage](https://codeclimate.com/github/GeorgeZhukov/shopping_cart/badges/coverage.svg)](https://codeclimate.com/github/GeorgeZhukov/shopping_cart/coverage)

## Installation

1. Add gem to your Gemfile
```
gem "shopping_cart"
```
2. Create shopping_cart.rb initializer
```
ShoppingCart.user_class = "User"
ShoppingCart.product_class = "Book"
ShoppingCart.current_user_method(&:current_or_guest_user)
```
3. Mount routes
```
mount ShoppingCart::Engine => '/shopping-cart', as: 'shopping_cart'
```
4. Copy and install migrations
```
rake shopping_cart:install:migrations
```
