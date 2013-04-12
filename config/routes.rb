Spree::Core::Engine.routes.append do

  namespace :admin do

    resources :relation_types
    resources :products do
      get :related, :on => :member
      resources :relations
    end

  end

end
