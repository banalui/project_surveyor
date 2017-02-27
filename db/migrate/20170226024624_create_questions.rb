class CreateQuestions < ActiveRecord::Migration[5.0]
  	def change
    	create_table :questions do |t|
    		t.string :text
    		t.string :type
			t.boolean :required, default: true

      		t.timestamps
    	end
  	end
end
