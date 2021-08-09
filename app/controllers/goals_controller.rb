class GoalsController < ApplicationController

  def index
    @goals = Goal.all
    render json: @goals, only: [:id, :title, :progress]
  end

  def show
    @goal = find_user
    render json: @goal, only: [:id, :title, :progress]
  end

  def update
    @goal = find_user
    @goal.update(goal_params)
    render json: @goal
  end

  private

  def find_user
    @goal = Goal.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:title, :progress)
  end
end
