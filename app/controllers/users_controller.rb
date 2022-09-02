class UsersController < ApplicationController
   before_action :require_user_logged_in,only: [:index,:show,:edit,:update,:new]
 def require_user_logged_in
  if @current_user.id != params[:id].to_i
    flash[:notice]="権限がありません"
    redirect_to root_url
  end
 end
 def show
   @user = User.find(params[:id])
   redirect_to root_url
 end
 def new
   @user = User.new
 end
 def create
   @user = User.new(user_params)
  if @user.save
   flash[:success] = 'ユーザを登録しました。'
   redirect_to @user
  else
   flash.now[:danger] = 'ユーザの登録に失敗しました。'
   render :new
  end
 end
  private
 def user_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation)
 end
end
