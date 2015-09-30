# -*- encoding : utf-8 -*-
class Frontend::BaseController < ApplicationController
  layout 'frontend'

  def authenticate_user
    if session[:user_id].blank?
      redirect_to user_signin_url
    end
  end

  def authenticate_expert
    if session[:expert_id].blank?
      redirect_to expert_signin_url
    end
  end
end