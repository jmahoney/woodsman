Woodsman::Application.routes.draw do
  
  # post editing done in the admin name space
  namespace :admin do
    resources :posts, constraints: {id: /\d{4}\/\d{2}\/[a-z|A-Z|\-|0-9]+/}
  end
  
  # Make Posts accessible from urls using the date_slug of the post
  # and without the /posts/ prefix (e.g.   /2001/02/this-is-the-slug)
  # Among other things, the constraints enable the slashes in the slugs
  resources :posts, only: [:show], path: '', constraints: {id: /\d{4}\/\d{2}\/[a-z|A-Z|\-|0-9]+/} do
    get "archive", on: :collection
  end
  
  # non-resourceful routes to handle date urls like /2004/04 & /2000
  # permanently redirect a url like /2004 to /archive
  get ":year", to: redirect("/archive"), constraints: {year: /\d{4}/}
  # url format for a month archive
  get ":year/:month", to: "posts#month", constraints: {year: /\d{4}/, month: /\d{2}/}
    
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root to: 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
