class CreateChoices < ActiveRecord::Migration[5.0]
  	def change
    	create_table :choices do |t|
    		t.string :text

      		t.timestamps
    	end
  	end
end
