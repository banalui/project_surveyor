module SurveysHelper
	def survey_params
    	params.require(:survey).permit(:title, :description)
  	end
end
