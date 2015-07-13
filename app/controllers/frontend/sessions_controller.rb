# -*- encoding : utf-8 -*-
class Frontend::SessionsController < Frontend::BaseController
  def create_user
    user = User.where(account: params[:account]).first
    if user.blank?
      redirect_to user_signin_url(:account => params[:account]), :flash => { :invalid_account => '账号不存在或输入不正确，请检查'}
    else
      if user.authenticate(params[:password])
        user.update(last_signined_at: user.current_signined_at, current_signined_at: Time.now)
        session[:user_id] = user.id
        session[:user_chinese_name] = user.chinese_name
        session[:user_last_signined_at] = user.last_signined_at
        redirect_to dashboard_users_url
      else
        redirect_to user_signin_url(:account => params[:account]), :flash => { :invalid_password => '密码输入不正确，请检查' }
      end
    end
  end

  def destroy_user
    session[:user_id] = nil
    session[:user_chinese_name] = nil
    session[:user_last_signined_at] = nil
    redirect_to user_signin_path
  end
end