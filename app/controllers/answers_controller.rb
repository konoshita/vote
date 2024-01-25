class AnswersController < ApplicationController
  before_action :set_answer, only: %i[ show edit ]

  # GET /answers or /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1 or /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers or /answers.json
  def create
    question = Question.find(params[:question_id])
    answer = Answer.new(answer_params)
    answer.question_id = question.id
    if answer.save
      flash[:success] = "ご回答ありがとうございます。"
      redirect_to root_path
    else
      flash[:success] = "ご回答が完了していません。"
        @question = Question.find(params[:post_image_id])
        @answer = Answer.new
        render 'question/show'
    end
  end

  # PATCH/PUT /answers/1 or /answers/1.json


  # DELETE /answers/1 or /answers/1.json


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def answer_params
      params.require(:answer).permit(:question_id, :body, :evaluation)
    end
end
