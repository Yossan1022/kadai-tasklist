class TasksController < ApplicationController
  
  before_action :correct_user, only: [:destroy]


def index
      @tasks = Task.all
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
    @tasklist.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def tasklist_params
    params.require(:task).permit(:content)
     params.require(:task).permit(:status)
  
  end
end