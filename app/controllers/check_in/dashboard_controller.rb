# -*- encoding : utf-8 -*-
class CheckIn::DashboardController < CheckIn::BaseController
  
  def index
    @participants = Participant.all
    @councilman_participants = @participants.select(&:type_councilman?)
    @invited_participants = @participants.select(&:type_invited?)
    @regular_participants = @participants.select(&:type_regular?)
    @visitor_participants = @participants.select(&:type_visitor?)
    @member_participants = @participants.select(&:is_member?)
    @hotel_participants = @participants.select{|participant| !participant.room.blank?}
    @hotels = Hotel.all
  end
end