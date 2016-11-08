Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    resources :group_events, only: [:index, :show, :update, :destroy, :create] do
      post 'publish', on: :member
    end
  end

end
