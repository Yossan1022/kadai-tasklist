class TasksController < ApplicationController
  
  before_action :correct_user, only: [:destroy]


def index
 
      @tasks = Task.all
end





def new
  @task = Task.new
end
  def create
    @tasklist = Task.new(tasklist_params)
    if @tasklist.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'tasks/index'
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
  
  end
end