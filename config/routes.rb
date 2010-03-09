map.namespace :admin do |admin|
  admin.resources :relation_types

  admin.resources :products, :member => {:related => :get}, :has_many => [:relations]
end
