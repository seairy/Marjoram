# -*- encoding : utf-8 -*-
class Frontend::AttachmentsController < Frontend::BaseController
  before_filter :authenticate_user
  before_filter :find_user

  def new
    @attachment = Attachment.new
  end

  def create
    @attachment = @user.attachments.new(attachment_params)
    if @attachment.save
      redirect_to show_project_users_path
    else
      render action: 'new'
    end
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    redirect_to show_project_users_path
  end

  protected
    def attachment_params
      params.require(:attachment).permit!
    end

    def find_user
      @user = User.find(session[:user_id])
    end
end
