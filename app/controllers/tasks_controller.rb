class TasksController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy, :update]
  
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

    if not ProjectUser.find_by(project_id: @task.project.id, user_id: @task.member.id)
      ProjectUser.create(project_id: @task.project.id, user_id: @task.member.id)
    end

    render :json => { task: @task.id, manager: @manager, owner: @owner }
  end

  def destroy
    @task = Task.find(params[:id])
    @project = @task.project
    
    if Task.find_by(user_id: @task.member.id, project_id: @project.id).present?
      ProjectUser.find_by(project_id: @task.project.id, user_id: @task.member.id).destroy
    end
    
    @task.destroy if @task.project.manager == current_user
    
    render :json => { task: @task.id }
  end

  def update
    @task = Task.find(params[:id])
    @task.update(complete: true)
    render :json => { task: @task.id }
  end
 
  private
  def task_params
  	params.require(:task).permit(:name, :description, :user_id, :project_id, :complete, :department_id, :priority, :deadline)
  end	

  def project_user_params
    params.require(:project).permit(:user_id, :project_id)
  end 
end
