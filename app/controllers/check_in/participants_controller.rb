# -*- encoding : utf-8 -*-
class CheckIn::ParticipantsController < CheckIn::BaseController
  def index
    @participants = case params[:type]
    when 'councilman' then Participant.type_councilmen
    when 'invited' then Participant.type_inviteds
    when 'regular' then Participant.type_regulars
    when 'visitor' then Participant.type_visitors
    else Participant.all
    end
    @participants = case params[:checked_in]
    when 'checked_in' then @participants.where(checked_in: true)
    when 'unchecked_in' then @participants.where(checked_in: false)
    else @participants
    end
    @participants = @participants.page(params[:page])
  end
  
  def show
    @participant = Participant.find(params[:id])
  end
  
  def new
    @participant = Participant.new
  end

  def create
    @participant = Participant.new(participant_params)
    @participant.checked_in = false
    if @participant.save
      redirect_to [:check_in, @participant], notice: '创建成功！'
    else
      render action: 'new'
    end
  end
  
  def edit
    @participant = Participant.find(params[:id])
  end
  
  def update
    @participant = Participant.find(params[:id])
    if @participant.update(participant_params)
      redirect_to [:check_in, @participant], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end
  
  def destroy
    @participant = Participant.find(params[:id])
    @participant.destroy
    redirect_to check_in_participants_path, notice: '删除成功！'
  end

  def check
    @participant = Participant.find(params[:id])
    @participant.update!(checked_in: true, checked_at: Time.now, staff_id: @current_staff.id)
    redirect_to [:check_in, @participant], notice: '确认报到成功！'
  end

  def restore
    @participant = Participant.find(params[:id])
    @participant.update!(checked_in: false, checked_at: nil, staff_id: nil)
    redirect_to [:check_in, @participant], notice: '取消报到成功！'
  end

  protected
    def participant_params
      params.require(:participant).permit!
    end
end
