class InnsController < ApplicationController
  def index
    @inns = Inn.all
  end

  def new
    @inn = Inn.new
    @user = User.find_by(id: session[:user_id])
  end

  def create
    @inn = Inn.new(inn_params)
    if @inn.save
      flash[:notice] = "宿を投稿しました"
      redirect_to user_path(session[:user_id])
    else
      render "new"
    end
  end

  def show
    @inn = Inn.find_by(id: params[:id])
    session[:inn_id] = params[:id]
  end
  
  def edit
    @inn = Inn.find_by(id: params[:id])
    kick_wrong_owner(@inn)
  end
  
  def update
    @inn = Inn.find_by(id: params[:id])
    kick_wrong_owner(@inn)
    if params[:inn][:image]
      image_name = "#{@inn.id}.jpg"
      params[:inn][:image_name] = image_name
      File.binwrite("public/inn_images/#{image_name}", params[:inn][:image].read)
    end
    if @inn.update(inn_params)
      flash[:notice] = "宿情報を更新しました"
      redirect_to inn_path(@inn.id)
    else
      render "edit"
    end
  end
  
  def destroy
    @inn = Inn.find_by(id: params[:id])
    kick_wrong_owner(@inn)
    @inn.delete
    flash[:notice] = "削除しました"
    redirect_to inns_path
  end
end

private
  def inn_params
    params.require(:inn).permit(:owner, :name, :price, :area, :address, :introduction, :image_name)
  end