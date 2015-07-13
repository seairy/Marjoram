# -*- encoding : utf-8 -*-
class Cms::BaseController < ApplicationController
  layout 'cms'

  before_action :authenticate
  
  protected
    def authenticate
      redirect_to cms_signin_path if session['administrator'].blank?
    end

    def convert_picker_to_datetime date, time
      "#{date} #{time}".to_datetime - 8.hours
    end
end
