module QuestionsHelper
	def question_params
    	params.require(:question).permit(:question_type, :survey_id, :choice_type, :num_choices, :text, :choices_attributes => [:text])
  	end
end
