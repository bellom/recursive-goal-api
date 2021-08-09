class GoalsController < ApplicationController

  after_action :update_progress, only: :update

  def index
    @goals = Goal.all
    render json: @goals, only: [:id, :title, :progress]
  end

  def show
    @goal = find_user.list_goals
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

  def update_progress(goal = nil)
    if goal != nil
      @goal = Goal.find(goal)
    else
      @goal = find_user
    end
    @current_goal_progress = @goal.progress
    return if @goal.parent.nil?
    @parent_goal = Goal.find(@goal.parent_id)
    @parent_goal.update(progress: @current_goal_progress / @parent_goal.children.size)
    @goal_next = @parent_goal.id
    update_progress(goal = @goal_next)
  end
end
