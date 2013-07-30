Spree::Core::Engine.routes.prepend do

  namespace :admin do

    resources :relation_types
    resources :products do
      get :related, :on => :member
      resources :relations do
      	collection do
        	post :update_positions
    	end
      end
    end
      
  end

end
