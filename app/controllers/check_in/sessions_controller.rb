# -*- encoding : utf-8 -*-
class CheckIn::SessionsController < CheckIn::BaseController
  skip_before_filter :authenticate, :find_notifications
  layout null: true

  def create
    staff = Staff.where(account: params[:account]).first.try(:authenticate, params[:password])
    unless staff.blank?
      if staff.available?
        staff.update_attribute :last_signined_at, staff.current_signined_at
        staff.update_attribute :current_signined_at, Time.now
        session[:staff] = { id: staff.id, name: staff.name, last_signined_at: staff.last_signined_at }
        redirect_to check_in_dashboard_path
      else
        redirect_to check_in_signin_path, alert: '账号被禁用，无法登录'
      end
    else
      redirect_to check_in_signin_path, alert: '账号或密码错误，请检查后重试'
    end
  end

  def destroy
    session[:staff] = nil
    redirect_to check_in_signin_path
  end
end
