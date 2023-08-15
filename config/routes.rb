# frozen_string_literal: true

Rails.application.routes.draw do
  resources :calculators, only: [:index, :create]

  root "calculators#index"
end
