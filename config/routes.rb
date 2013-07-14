Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :relation_types
    resources :products, only: [:index, :show] do
      get :related, on: :member
      resources :relations
    end
  end
end
