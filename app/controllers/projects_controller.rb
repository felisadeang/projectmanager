class ProjectsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]

  def new
    @user = current_user
  end

  def create
  	@project = Project.new(project_params)
  	if @project.save
  		redirect_to "/users/#{current_user.id}"
  	else
  		flash[:errors] = @project.errors.full_messages
      	redirect_to :back
      end
  end

  def destroy
    project = Project.find(params[:id])
    project.destroy if project.manager == current_user
    redirect_to "/users/#{current_user.id}"
  end

  private
  def project_params
  	params.require(:project).permit(:name, :description, :user_id, :deadline, :department_id)
  end
end
