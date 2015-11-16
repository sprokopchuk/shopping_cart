# desc "Explaining what the task does"
# task :shopping_cart do
#   # Task goes here
# end
namespace :shopping_cart do

  task :install do
    system 'rake g shopping_cart:install'
  end
end

