Rails.application.routes.draw do
	root to: 'surveys#index'
	resources :surveys do
		resources :questions do

		end
	end
end
