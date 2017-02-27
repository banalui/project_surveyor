module QuestionsHelper
	def question_params
    	params.require(:question).permit(:type, :survey_id)
  	end
end
