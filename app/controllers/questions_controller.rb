class QuestionsController < ApplicationController
	before_action :set_question, only: %i(edit update destroy)

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
			@questions = Question.all
			render 'index'
		end
	end

  def edit
  end

	def update
		@question.question_similars.destroy_all
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
		# 初期データ作成
		if session[:correct] == nil && session[:incorrect] == nil
			@already_asked = []
			session[:correct] = 0
			session[:incorrect] = 0
		end

		# 既に出題された問題を取得して、出題されないようにする
		@already_asked = params[:question_ids].split(",") if params[:question_ids]
		question_id = params[:question_id]
		@already_asked.push(question_id.to_i)
		@question = Question.where.not(id: @already_asked).order("RANDOM()").limit(1)

		# 正解数と不正解数をセッションで管理
		session[:correct] += 1 if params[:answer] == '正解'
		session[:incorrect] += 1 if params[:answer] == '不正解'
		@number = session[:correct] + session[:incorrect] + 1

		# 最終問題回答後の処理
		if @number == 11
			rate = (session[:correct] * 100) / 10 # 正解率を計算
			rank = @current_user.my_rank(@current_user) # 自分の順位を計算
			# 最高正解率を更新
			if rate > @current_user.highest_rate
				@current_user.highest_rate = rate
				@current_user.save
			end
			flash[:notice] = "お疲れ様でした！\n あなたの成績は、10問中#{ session[:correct] }問正解 正解率#{ rate }%で#{ rank }位でした"
			@number = 0
			@already_asked = []
			session[:correct] = nil
			session[:incorrect] = nil
			@users = User.ranking
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
