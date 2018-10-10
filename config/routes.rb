Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'quotes/index'
      get 'quotes/create'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
