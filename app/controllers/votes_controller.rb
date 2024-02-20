class VotesController < ApplicationController
  before_action :set_vote, only: %i[ show edit ]

  # GET /votes or /votes.json
  def index
    @votes = Vote.all
  end

  # GET /votes/1 or /votes/1.json
  def show
    @answer = Answer.new
  end

  # GET /votes/new
  def new
    @vote = Vote.new
  end

  # GET /votes/1/edit
  def edit
    @answer = Answer.new
    @answers = @vote.answers.order("RANDOM()").all
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

  # POST /votes or /votes.json
  def create
    @vote = Vote.new(vote_params)
      if @vote.save
        flash[:success] = "質問が作成されました"
        redirect_to root_path
      else
        render :new, status: :unprocessable_entity 
      end
  end

  # PATCH/PUT /votes/1 or /votes/1.json

  # DELETE /votes/1 or /votes/1.json


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vote_params
      params.require(:vote).permit(:title, :description)
    end
end
