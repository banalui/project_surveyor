class QuestionsController < ApplicationController
	include QuestionsHelper

	def create
		@survey = Survey.find(params[:survey_id])
		@question = @survey.questions.build()
		@question.survey_id = @survey.id
		@question.type = params[:type]
		if @question.save
			redirect_to edit_survey_question_path(@survey.id, params[:id])
		else

		end
	end
end
