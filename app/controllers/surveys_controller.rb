class SurveysController < ApplicationController

	include SurveysHelper

	def index
		@surveys = Survey.all
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
		@no_question_yet = (@survey.questions.size == 0)
		@question = Question.new
		@question_types= ['Multiple Choice']
		@alfabets = ('a'..'z').to_a
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

	def participate
		@survey = Survey.find(params[:id])
	end

	def generate_result
		@survey = Survey.find(params[:id])
		params[:survey][:qid].each do |question_id, question_results|
			@question = @survey.questions.find(question_id)
			question_results.each do |choice_id, choice_result|
				if choice_id == 'choice'
					# Radio Button
					@choice = @question.choices.find(choice_result['checked_count'].to_i)
					@choice.checked_count = @choice.checked_count + 1
					@choice.save!
				else
					# Checkbox
					if choice_result['checked_count'] == "1"
						@choice = @question.choices.find(choice_id)
						@choice.checked_count = @choice.checked_count + 1
						@choice.save!
					end
				end
			end
		end
		redirect_to surveys_path
	end
end
