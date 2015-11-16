# ShoppingCart

This simple Rails Engine. Shopping Cart consists cart, checkout and orders.

## Installation
```ruby
gem 'shopping_cart', git: 'git://github.com/sprokopchuk/shopping_cart'
```
And then execute:

    $ bundle

## Usage
Run to create initializer and migrations for ShoppingCart::Engine.

```ruby
rake shopping_cart:install
```
This is also add routes into your routes 'config/routes.rb'::
```ruby
mount ShoppingCart::Engine => '/'
```
And then run:
```ruby
rake db:migrate
```
Add to your User model:
```ruby
class User < ActiveRecord::Base
  ...
  has_shopping_cart
end
```
Add to your Product model:
```ruby
class Product < ActiveRecord::Base
  ...
  act_as_cartable
end
```

## Helpers

ShoppingCart::Engine will create helper to use inside your controllers and views.
For the current user, this helper is available:

    current_cart

Add a product to the cart:

    = button_to 'Add to cart', shopping_cart.order_items_path(cartable_id: product, cartable_type: product.class)

## Configuring views

Since ShoppingCart::Engine is an engine, all its views are packaged inside the gem. These views will help you get started, but after some time you may want to change them. If this is the case, you just need to invoke the following generator, and it will copy all views to your application:

    rails generate shopping_cart:views
