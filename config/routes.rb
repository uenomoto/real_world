Rails.application.routes.draw do
  scope :api do
    resources :articles, param: :slug, only: %i[create show update destroy]
  end
end
