Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :links

  get '/:slug', to: 'links#redirect', as: 'redirect'
end
