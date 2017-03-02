Rails.application.routes.draw do
	root to: 'surveys#index'
	resources :surveys do
		resources :questions do
			#resources :choices
			get 'add_choices', :on => :collection
			patch 'update_choices', :on => :collection
		end
	end
end
