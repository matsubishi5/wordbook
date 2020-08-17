class QuestionsController < ApplicationController
	def index
		@question = Question.new
		@questions = Question.all
	end

	def create
		@question = Question.new(question_params)
		if @question.save
			redirect_to questions_path(@question)
		else
			@questions = question.all
			render 'index'
		end
	end

  def edit
  end

  def update
		@question.update(question_params) ? (redirect_to questions_path) : (render 'edit')
  end

	def destroy
		@question.destroy
		redirect_to questions_path
  end

  def search
    @questions = Question.search(params[:search])
  end

	private

		def set_question
			@question = Question.find(params[:id])
		end

		def question_params
			params.require(:question).permit(:question, :description)
		end
end
