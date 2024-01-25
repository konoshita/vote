class QuestionsController < ApplicationController
  before_action :set_question, only: %i[ show edit update destroy ]

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
    @answers = @question.answers.all
    unless @answers.count < 5
      flash[:notice] = "まだ回答数が足りません"
      redirect_to root_pathh
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
        redirect_to question_url(@question), notice: "Question was successfully created."
      else
        render :new, status: :unprocessable_entity 
      end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to question_url(@question), notice: "Question was successfully updated." }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1 or /questions/1.json
  def destroy
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url, notice: "Question was successfully destroyed." }
      format.json { head :no_content }
    end
  end

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
