class ChoicesController < ApplicationController
	include ChoicesHelper

	def new
		@survey = Survey.find(params[:survey_id])
		@question = Question.find(params[:question_id])
	end
end
