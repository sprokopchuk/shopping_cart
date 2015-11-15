module ShoppingCart
  class ApplicationController < ::ApplicationController
    include Devise::Controllers::Helpers
    include ShoppingCart::CartHelper

  end
end
