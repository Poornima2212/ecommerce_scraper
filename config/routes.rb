Rails.application.routes.draw do
  resources :products do
    collection do
      get :search
    end
  end
  root "products#index"
end