class CreateAnswers < ActiveRecord::Migration[5.0]
  	def change
    	add_column :choices, :checked, :boolean
  	end
end