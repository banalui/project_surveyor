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

	def generate_result
		should_save = true
		@survey = Survey.find(params[:id])
		params[:survey][:qid].each do |question_id, question_results|
			@question = @survey.questions.find(question_id.to_i)
			if @question.choice_type == 'Just One'
				# Radio Button, no need to validate
				@choice = @question.choices.find(question_results['choice']['checked_count'])
				@choice.checked_count = @choice.checked_count + 1
			else
				# Checkbox, need to check for all 0
				if @question.required
					unless question_results['choice']['checked_count'].include? "1"
						should_save = false
					end
				end
				@question.choices.each_with_index do |choice, index|
					if question_results['choice']['checked_count'][index] == "1"
						choice.checked_count = choice.checked_count + 1
					end
				end
			end
		end
		if should_save
			@survey.response_count = @survey.response_count + 1
			@survey.save!
			@question.choices.each do |choice|
				choice.save!
			end
			flash[:success] = "You took survey completely"
			redirect_to surveys_path
		else
			flash[:error] = "You did not answer a required question!"
			redirect_to(:action => "participate") and return if true
		end
		#@survey = Survey.find(params[:id])
		# @survey.response_count = @survey.response_count + 1
		# @survey.save!
		# params[:survey][:qid].each do |question_id, question_results|
		# 	@question = @survey.questions.find(question_id)
		# 	question_results.each do |choice_id, choice_result|
		# 		if choice_id == 'choice'
		# 			# Radio Button
		# 			@choice = @question.choices.find(choice_result['checked_count'].to_i)
		# 			@choice.checked_count = @choice.checked_count + 1
		# 			@choice.save!
		# 		else
		# 			# Checkbox
		# 			if choice_result['checked_count'] == "1"
		# 				@choice = @question.choices.find(choice_id)
		# 				@choice.checked_count = @choice.checked_count + 1
		# 				@choice.save!
		# 			end
		# 		end
		# 	end
		# end
		
	end
end
