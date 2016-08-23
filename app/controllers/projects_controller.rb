class ProjectsController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy]
  
  def new
  end

  def create
  	@project = Project.new(project_params)
  	if @project.save
  		redirect_to user_path(@project.user_id)
  		# redirect_to user_path(@project.manager_id)
  	else
  		flash[:errors] = @project.errors.full_messages
      	redirect_to user_path(@project.user_id)
      	# redirect_to user_path(@project.manager_id)
      end
  end

  def destroy
    project = Project.find(params[:id])
    project.destroy if project.manager == current_user
    redirect_to "/users/#{current_user.id}"
  end
 
  private
  def project_params
  	params.require(:project).permit(:name, :description, :manager_id, :deadline, :department_id)
  end	
end
