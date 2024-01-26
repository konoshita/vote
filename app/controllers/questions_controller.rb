class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit ]

  # GET /questions or /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1 or /questions/1.json
  def show
    @answer = Answer.new
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
    @answer = Answer.new
    @answers = @question.answers.order("RANDOM()").all
    if @answers.count < 5
      flash[:warning] = "まだ回答数が足りません"
      redirect_to root_path
    end
    @evaluation = Answer.pluck(:evaluation)
    @aggregate = aggregateevaluation(@evaluation)
    @sum = sumevaluation(@evaluation)
  end

  def aggregateevaluation(array)
    result = [["賛成",0],["反対",0],["どちらでもない",0],["無回答",0]]
    array.each do |i|
      if i == 1
        result[0][1] += 1
      elsif i == 0
        result[1][1] += 1
      elsif i == nil
        result[3][1] += 1
      else 
        result[2][1] += 1
      end
    end
    return result
  end

  def sumevaluation(array)
    result = [["総投票数",0],["有効投票数",0],["無効投票数",0]]
    array.each do |i|
      if i == nil
        result[2][1] += 1
      else 
        result[1][1] += 1
      end
    end
    result[0][1] = array.length 
    return result
  end

  # POST /questions or /questions.json
  def create
    @question = Question.new(question_params)
      if @question.save
        redirect_to root_path, notice: "質問が作成されました"
      else
        render :new, status: :unprocessable_entity 
      end
  end

  # PATCH/PUT /questions/1 or /questions/1.json

  # DELETE /questions/1 or /questions/1.json


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:title, :description)
    end
end
