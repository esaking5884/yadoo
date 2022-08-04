class InnsController < ApplicationController
  def index
    @inns = Inn.all
  end

  def new
    @inn = Inn.new
    @user = User.find_by(id: session[:user_id])
    @inn_image = InnImage.new
  end

  def create
    @inn = Inn.new(inn_params)
    @user = User.find(session[:user_id])
    @sub_image = InnImage.new(inn_image_params)
    if @inn.save
      flash[:notice] = "宿を投稿しました"
      redirect_to user_path(session[:user_id])
    else
      render "new"
    end
  end

  def show
    @inn = Inn.find(params[:id])
  end
  
  def edit
    @inn = Inn.find(params[:id])
    kick_wrong_owner(@inn)
  end
  
  def update
    @inn = Inn.find(params[:id])
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
    @inn.destroy
    flash[:notice] = "削除しました"
    redirect_to inns_path
  end
  
  def search
    @options = Inn.pluck(:area)
    @area = params[:area]
    if params[:area] == ""
      @inns = Inn.where("name LIKE ? OR introduction LIKE ?", "%#{params[:word]}%", "%#{params[:word]}%")
    else
      @inns = Inn.where("(name LIKE ? OR introduction LIKE ?) AND area LIKE ?", "%#{params[:word]}%", "%#{params[:word]}%", "#{params[:area]}")
    end
    render "index"
  end
  
  def edit_image
    @inn_image = InnImage.new
    t = Time.now.strftime("%Y%m%d%H%M%S")
    @image_name = "#{t}.jpg"
    @inn = Inn.find(params[:id])
    @inn_images = @inn.inn_images
  end
  
  def create_image
    if params[:inn_image][:image]
      File.binwrite("public/inn_sub_images/#{params[:inn_image][:image_name]}", params[:inn_image][:image].read)
    else
      flash[:notice] = "ファイルを選択してください"
      render "edit_image"
    end
    @inn_image = InnImage.new(inn_image_params)
    if @inn_image.save
      flash[:notice] = "画像を追加しました"
      redirect_to "/inns/#{@inn_image.inn_id}/edit_image"
    else
      flash[:notice] = "登録に失敗しました"
      render "edit_image"
    end
  end

  def destroy_image
    @inn_image = InnImage.find(params[:id])
    @inn_image.destroy
    flash[:notice] = "削除しました"
    redirect_to "/inns/#{@inn_image.inn_id}/edit_image"
  end

  def edit_image_order
    @inn_image = InnImage.find(params[:id])
    if @inn_image.update(inn_image_params)
      flash[:notice] = "表示順序を更新しました"
      redirect_to "/inns/#{@inn_image.inn_id}/edit_image"
    else
      render "edit_image"
    end
  end
end

private
  def inn_params
    params.require(:inn).permit(:owner, :name, :price, :area, :address, :introduction, :image_name)
  end

  def inn_image_params
    params.require(:inn_image).permit(:inn_id, :image_name, :order)
  end