# -*- encoding : utf-8 -*-
class Cms::BaseController < ApplicationController
  layout 'cms'

  before_action :authenticate
  
  def authenticate
    redirect_to cms_signin_path if session['administrator'].blank?
  end
end
