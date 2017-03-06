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

	def result
		@survey = Survey.find(params[:id])
	end

	def generate_result
		should_save = true
		found_selection = false
		@survey = Survey.find(params[:id])
		if params[:survey]
			params[:survey][:qid].each do |question_id, question_results|
				@question = @survey.questions.find(question_id.to_i)
				unless @question.choice_type == 'Just One'
					if @question.required
						found_selection = false
						question_results.each do |choice_id, value|
							value.each do |key_checked_count, checked_array|
								if checked_array.size > 1
									found_selection = true
								end
							end
						end
						unless found_selection
							should_save = false
						end
					end
				end
			end
		else
			redirect_to surveys_path and return if true
		end
		if should_save
			@survey.response_count = @survey.response_count + 1
			@survey.save!
			params[:survey][:qid].each do |question_id, question_results|
				@question = @survey.questions.find(question_id.to_i)
				if @question.choice_type == 'Just One'
					@choice = @question.choices.find(question_results['choice']['checked_count'])
					@choice.checked_count = @choice.checked_count + 1
					@choice.save!
				else
					question_results.each do |choice_id, value|
						value.each do |key_checked_count, checked_array|
							if checked_array.size > 1
								@choice = @question.choices.find(choice_id)
								@choice.checked_count = @choice.checked_count + 1
								@choice.save!
							end
						end
					end
				end
			end
			flash[:success] = "You took survey completely"
			redirect_to surveys_path
		else
			flash[:error] = "You did not answer a required question!"
			redirect_to(:action => "participate") and return if true
		end
	end
end
