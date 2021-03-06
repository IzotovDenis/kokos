Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

post 'sign_in', to: 'auth#sign_in'

namespace :admin do
  resources :items
  resources :groups
  post '/item_image', to: 'item_images#create'
  resources :orders
  resources :brands
  resources :discounts
end

namespace :v1 do
  post 'search', to: "search#index"
  resources :groups
  resources :discounts
  resources :orders do
    collection do
      post 'getOrderItems'
    end
  end
  resources :items do 
    collection do
      get 'rand'
    end
  end
  resources :orders
end

end
