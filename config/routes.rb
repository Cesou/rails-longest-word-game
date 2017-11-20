Rails.application.routes.draw do

  root 'longestwords#game'

  get 'game', to: 'longestwords#game'

  get 'score', to: 'longestwords#score'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
