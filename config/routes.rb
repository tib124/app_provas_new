Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  get "dashboard" => "dashboard#show", as: :dashboard

  resources :alunos, only: %i[index new create edit update destroy] do
    collection do
      get :import
      post :process_import
    end
  end

  resources :turmas

  resources :provas, only: %i[index show new create edit update destroy] do
    collection do
      get :import
      post :process_import
    end
    member do
      post :corrigir_ia
    end
    get "gabarito" => "gabaritos#index", as: :gabarito

    resources :questoes, only: %i[index new create edit update destroy] do
      resource :gabarito, only: %i[new create edit update destroy]
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  authenticated :user do
    root "dashboard#show", as: :authenticated_root
  end
  root "pages#home"
end
