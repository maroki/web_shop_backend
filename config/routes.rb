Rails.application.routes.draw do
  resources :products, except: [:new, :edit]
  resources :baskets, except: [:new, :edit, :index]
end
