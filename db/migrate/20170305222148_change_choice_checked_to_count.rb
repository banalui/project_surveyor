class ChangeChoiceCheckedToCount < ActiveRecord::Migration[5.0]
  	def change
  		remove_column :choices, :checked
  		add_column :choices, :checked_count, :integer
  	end
end
