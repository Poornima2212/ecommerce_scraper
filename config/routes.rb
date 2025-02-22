Rails.application.routes.draw do
  root "products#index"
  resources :categories
  resources :products do
    member do
      post :refresh
    end
    collection do
      get :search
    end
  end
end