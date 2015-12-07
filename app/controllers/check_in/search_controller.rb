# -*- encoding : utf-8 -*-
class CheckIn::SearchController < CheckIn::BaseController

  def create
    keyword = params[:keyword].strip
    @participants = Participant.where("name LIKE '%#{keyword}%' OR phone_number LIKE '%#{keyword}%' OR subject LIKE '%#{keyword}%'") unless keyword.blank?
    render 'result'
  end
end