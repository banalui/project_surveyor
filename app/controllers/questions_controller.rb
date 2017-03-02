class QuestionsController < ApplicationController
	include QuestionsHelper

	def create
		@survey = Survey.find(params[:survey_id])
		@question = @survey.questions.build()
		@question.question_type = params[:question][:question_type]
		if @question.save
			flash[:success] = "Question created successfully"
			redirect_to edit_survey_question_path(@survey.id, @question.id)
		else

		end
	end

	def edit
		@survey = Survey.find(params[:survey_id])
		@question = Question.find(params[:id])
		@choices_max = (1..10).to_a
	end

	def update
		@question = Question.find(params[:id])
		@question.num_choices = params[:question][:num_choices].to_i
		@question.choice_type = params[:question][:choice_type]
		@question.required = (params[:question][:num_choices].to_i) ? true : false
		if @question.save
			redirect_to add_choices_survey_questions_path(params[:survey_id], @question.id)
		else

		end
	end

	def add_choices
		@question = Question.find(params[:format])
		@question.num_choices.times do
			@question.choices.build
		end
		@survey = Survey.find(params[:survey_id])
	end

	def update_choices
		puts "\n\n\n\n Printing Params \n\n\n\n"
		params.each do |key, value|
			puts "#{key} => #{value}"
		end
		puts "\n\n\n\n Printing Params question \n\n\n\n"
		params[:question].each do |key, value|
			puts "#{key} => #{value}"
		end
		@survey = Survey.find(params[:survey_id])
		@question = @survey.questions.last
		if @question.update(question_params)			
			flash[:success] = "Great! Your question has been updated!"
			redirect_to surveys_path
		else
			flash[:error] = "Could not update!"
			render action: "add_choices"
		end
	end
end
