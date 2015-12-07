# -*- encoding : utf-8 -*-
class CheckIn::BaseController < ApplicationController
  layout 'check_in'

  before_action :authenticate
  
  protected
    def authenticate
      begin
        @current_staff = Staff.find(session['staff']['id'])
      rescue
        redirect_to check_in_signin_path
      end
    end

    def convert_picker_to_datetime date, time
      "#{date} #{time}".to_datetime - 8.hours
    end
end
