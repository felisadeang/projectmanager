class TasksController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]
  
  def new
  end

  def create
  	@task = Task.new(task_params)
  	if @task.save
  		redirect_to user_path(@task.project_id)
  	else
  		flash[:errors] = @task.errors.full_messages
      	redirect_to user_path(@task.project_id)
      end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy if task.project.manager == current_user
    redirect_to "/users/#{current_user.id}"
  end
 
  private
  def task_params
  	params.require(:task).permit(:name, :description, :member_id, :project_id, :complete)
  end	
end
