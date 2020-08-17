class QuestionsController < ApplicationController
	def index
		@question = Question.new
		@question.question_similars.build
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

	def learning
		@question = Question.order("RANDOM()").limit(1)

		if session[:correct] == nil && session[:incorrect] == nil
			session[:correct] = 0
			session[:incorrect] = 0
		end

		session[:correct] += 1 if params[:answer] == '正解'
		session[:incorrect] += 1 if params[:answer] == '不正解'
		if session[:correct] + session[:incorrect] == 1
			rate = (session[:correct] * 100) / 10
			session[:correct] = nil
			session[:incorrect] = nil
			flash[:notice] = "お疲れ様でした！\n あなたの成績は、50門中50門正解 正解率#{rate}%で1位でした"
			redirect_to ranking_users_path
		end
	end

	private

		def set_question
			@question = Question.find(params[:id])
		end

		def question_params
			params.require(:question).permit(:question, :description, question_similars_attributes: [:similar_word])
		end
end
