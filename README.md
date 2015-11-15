# ShoppingCart

This simple Rails Engine. Shopping Cart consists cart, checkout and orders.

## Installation
```ruby
gem 'shopping_cart', git: 'git://github.com/sprokopchuk/shopping_cart'
```
And then execute:

    $ bundle

## Usage
Mount ShoppingCart::Engine in your routes `config/routes.rb`:
```ruby
mount ShoppingCart::Engine => '/'
```
Run to create initializer and migrations for ShoppingCart::Engine:

```ruby
rake shopping_cart:install
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

