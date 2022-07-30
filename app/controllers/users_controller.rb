class UsersController < ApplicationController
  before_action :logged_in_user, only:[:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    @reservations = @user.reservations.order(check_in: "DESC")
    @own_inns = @user.inns
    unless current_user?(@user)
      redirect_to login_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(post_params)
    @user.image_name = "default.jpg"
    if @user.save
      flash[:notice] = "登録しました"
      log_in(@user)
      redirect_to user_path(@user.id)
    else
      render "new"
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if params[:user][:image]
      image_name = "#{@user.id}.jpg"
      params[:user][:image_name] = image_name
      File.binwrite("public/user_images/#{image_name}", params[:user][:image].read)
    end
    if @user.update(post_params)
      flash[:notice] = "アカウント情報を更新しました"
      redirect_to user_path
    else
      render "/users/#{@user.id}/edit"
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    log_out
  end
end

private
  def post_params
    params.require(:user).permit(:name, :account_name, :email, :phone_number,  :introduction, :image_name, :password, :password_confirmation)
  end