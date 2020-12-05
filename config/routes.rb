Rails.application.routes.draw do
 resources :users

 get 'show' => 'users#show'
 root 'users#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
