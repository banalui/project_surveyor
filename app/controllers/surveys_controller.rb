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
		@question = @survey.questions.build()
		@question_types= ['Multiple Choice']
	end

	def update
		@survey = Survey.find(params[:id])
		@question = @survey.questions.build()
		puts "\n\n\n\n params type #{params[:type]}\n\n\n"
		@question.type = params[:type]
		if @question.save
			flash[:success] = "Question created successfully"
			redirect_to edit_survey_question_path(@survey.id, @question.id)
		else
			flash[:error] = "Question creation failed"
			render action: "edit"
		end
	end
end
