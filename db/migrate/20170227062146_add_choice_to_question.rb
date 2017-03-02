class AddChoiceToQuestion < ActiveRecord::Migration[5.0]
	def change
		add_column :questions, :num_choices, :integer
		add_column :questions, :choice_type, :string
  	end
end
