# -*- encoding : utf-8 -*-
class Cms::UsersController < Cms::BaseController
  def index
    @users = User.latest.page(params[:page])
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to [:cms, @user], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def trash
    @user = User.find(params[:id])
    @user.trash!
    redirect_to cms_users_path, notice: '删除成功！'
  end

  def accepted
    @users = User.accepted.latest.page(params[:page])
  end

  protected
    def user_params
      params.require(:user).permit!
    end
end
