Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :relation_types
    resources :products, only: [] do
      get :related, :on => :member
      resources :relations do
      	collection do
        	post :update_positions
    	end
      end
    end
  end

  namespace :api, :defaults => { :format => 'json' } do
    resources :products, only: [] do
      get :related, :on => :member
      resources :relations do
        collection do
          post :update_positions
        end
      end
    end
  end
end
