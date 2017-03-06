class AddResponseCountToSurvey < ActiveRecord::Migration[5.0]
  	def change
  		add_column :surveys, :response_count, :integer
  	end
end
