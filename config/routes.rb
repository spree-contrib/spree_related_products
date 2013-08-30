Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :relation_types
    resources :products, only: [] do
      get :related, :on => :member
      resources :relations
    end
  end
end
