Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

namespace :admin do
  resources :items
  resources :groups
  post '/item_image', to: 'item_images#create'
  resources :orders
  resources :brands
end

namespace :v1 do
  resources :groups
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
