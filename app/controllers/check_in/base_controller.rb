# -*- encoding : utf-8 -*-
class CheckIn::BaseController < ApplicationController
  layout 'check_in'

  before_action :authenticate
  
  protected
    def authenticate
      redirect_to check_in_signin_path if session['staff'].blank?
    end

    def convert_picker_to_datetime date, time
      "#{date} #{time}".to_datetime - 8.hours
    end
end
