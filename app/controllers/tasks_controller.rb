class TasksController < ApplicationController
  
  before_action :correct_user, only: [:destroy]

 
 def index
      @tasks = Task.all
 end
 def edit
   @task = Task.find(params[:id])
 end
def show
  @task = Task.find(params[:id])
end
def new
  @task = Task.new
end
  def create
    @task = Task.new(tasklist_params)
    if @task.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'tasks/new'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def tasklist_params
    params.require(:task).permit(:content, :status).merge(user_id: current_user.id)
  
  end
end