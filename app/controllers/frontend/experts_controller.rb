# -*- encoding : utf-8 -*-
class Frontend::ExpertsController < Frontend::BaseController
  before_filter :authenticate_expert

  def dashboard
    @expert = Expert.find(session[:expert_id])
  end
  
  def update_password
    @expert = Expert.find(session[:expert_id])
    if !@expert.authenticate(params[:original_password])
      flash[:alert] = '原密码输入不正确'
    elsif params[:new_password] != params[:confirmed_password]
      flash[:alert] = '两次新密码输入不一致'
    elsif params[:new_password].blank?
      flash[:alert] = '新密码不能为空'
    elsif params[:new_password] !~ /^[a-zA-Z0-9_]{6,16}$/
      flash[:alert] = '新密码只能使用英文、数字及下划线，并保持长度为6至16位'
    else
      @expert.update_password(params[:new_password])
      flash[:notice] = '密码修改成功'
    end
    redirect_to edit_password_experts_url
  end

  protected
    def expert_params
      params.require(:expert).permit!
    end
end
