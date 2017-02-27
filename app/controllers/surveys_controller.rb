class SurveysController < ApplicationController

	include SurveysHelper

	def index
		
	end

	def new
		@survey = Survey.new
	end

	def create
		@survey = Survey.new(survey_params)
		if @survey.save
			flash[:success] = "Survey created successfully"
			redirect_to edit_survey_path(@survey.id)
		else
			flash[:error] = "Survey creation failed"
			render action: "new"
		end
	end

	def edit
		@survey = Survey.find(params[:id])
		@question = @survey.questions.build();
		@question_types= ['Multiple Choice']
	end
end
