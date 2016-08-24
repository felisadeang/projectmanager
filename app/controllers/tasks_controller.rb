class TasksController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]
  
  def new
  end

  def create
    @task = Task.create(task_params)
    render :json => { message:  "Hello?" }
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy if task.project.manager == current_user
    redirect_to "/users/#{current_user.id}"
  end
 
  private
  def task_params
  	params.require(:task).permit(:name, :description, :user_id, :project_id, :complete, :department_id)
  end	
end
