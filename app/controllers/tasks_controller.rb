class TasksController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]
  
  def new
  end


  def create
    @task = Task.new

  end

  def destroy
    task = Task.find(params[:id])
    task.destroy if task.project.manager == current_user
    redirect_to "/users/#{current_user.id}"
  end

  def team
    department_id = Department.find(params[:department_id])
    respond_to do |format|
    format.json { render :json => department.team }
    end
  end
 
  private
  def task_params
  	params.require(:task).permit(:name, :description, :member_id, :project_id, :complete)
  end	
end
