class TasksController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]
  
  def new
  end

  # def create
  #   task = Task.create(task_params)
  #   respond_to do |format|
  #     format.html do
  #       # redirect_to projects_path(task.project.id)
  #     end
  #   end
  # end

  # Task.where("id > 2 AND id < 11").delete_all
  def create
    @task = Task.create(task_params)
    render :json => { message:  "Hello?" }
    # redirect_to :back

    # if @task.save
    #   redirect_to "/users/#{current_user.id}"
    # else
    #   flash[:errors] = @task.errors.full_messages
    #     redirect_to :back
    # end
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
