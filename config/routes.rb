Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root to: 'statics#index'
  # mount Monologue::Engine, at: '/blog'
  mount ApplicationAPI => '/api'
end
