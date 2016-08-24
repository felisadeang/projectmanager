class TasksController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]
  
  def new
  end

  def create
    @task = Task.create(task_params)
    @project = @task.project
    @manager = false
    @owner = false

    if @task.project.manager == current_user
      @manager = true
    elsif @task.member == current_user
      @owner = true
    end
    render :json => { task: @task.id, manager: @manager, owner: @owner }
  end

  def destroy
    task = Task.find(params[:id])
    @task = task.id
    task.destroy if task.project.manager == current_user
    
    render :json => { task: @task }
  end

  def update
    task = Task.find(params[:id])
    task.update(complete: true)
    @task = task.id
    render :json => { task: @task }
  end
 
  private
  def task_params
  	params.require(:task).permit(:name, :description, :user_id, :project_id, :complete, :department_id)
  end	
end
