Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :trips, only: [:index, :show, :create]
    end
  end

  get "/up", to: "rails/health#show"

end
