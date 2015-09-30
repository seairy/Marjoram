# -*- encoding : utf-8 -*-
class Frontend::UsersController < Frontend::BaseController
  before_filter :authenticate_user, except: [:new, :create]

  def dashboard
    @user = User.find(session[:user_id])
  end
  
  def show_project
    @user = User.find(session[:user_id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(session[:user_id])
  end
  
  def edit_project
    @user = User.find(session[:user_id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render 'create_successful'
    else
      render action: 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      params[:edit_thesis] ? redirect_to(show_thesis_user_path(@user), :notice => '论文信息修改成功') : redirect_to(edit_user_path(@user), :notice => '个人信息更新成功')
    else
      params[:edit_thesis] ? render(action: 'edit_thesis') : render(action: 'edit')
    end
  end

  def update_project
    @user = User.find(session[:user_id])
    if @user.update(user_params)
      redirect_to show_project_users_path, :notice => '论文信息修改成功'
    else
      render action: 'edit_project'
    end
  end
  
  def update_password
    @user = User.find(session[:user_id])
    if !@user.authenticate(params[:original_password])
      flash[:alert] = '原密码输入不正确'
    elsif params[:new_password] != params[:confirmed_password]
      flash[:alert] = '两次新密码输入不一致'
    elsif params[:new_password].blank?
      flash[:alert] = '新密码不能为空'
    elsif params[:new_password] !~ /^[a-zA-Z0-9_]{6,16}$/
      flash[:alert] = '新密码只能使用英文、数字及下划线，并保持长度为6至16位'
    else
      @user.update_password(params[:new_password])
      flash[:notice] = '密码修改成功'
    end
    redirect_to edit_password_users_url
  end
  
  def invitation
    @user = User.find(session[:user_id])
    render :layout => nil
  end

  protected
    def user_params
      params.require(:user).permit!
    end
end
