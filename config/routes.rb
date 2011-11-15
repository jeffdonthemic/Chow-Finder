ChowFinder::Application.routes.draw do

  get "content/home"
  get "content/about"

  get "location/index",             as: 'locations'
  get "location/favorites"
  get "location/states"    
  get "location/new",               as: 'new'
  post "location/create",           as: 'create'
  get "location/edit"
  match "/location/:id",            to: "location#show", as: 'location'
  match "/location/:id/favorite",   to: "location#favorite", as: 'favorite'  

  match "facility/:id",             to: "facility#show", as: 'facility_show'
  match "facility/new/:id",         to: "facility#new", as: 'facility_new'
  match "facility/create/:id",      to: "facility#create", as: 'facility_create'
  match "facility/edit/:id",        to: "facility#edit", as: 'facility_edit'
  match "facility/update/:id",      to: "facility#update", as: 'facility_update'
    
  root :to => 'content#home'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
