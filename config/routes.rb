Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :trips, only: [:index, :create]
    end
  end

  get "/up", to: "rails/health#show"

end
