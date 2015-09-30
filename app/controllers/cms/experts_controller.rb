# -*- encoding : utf-8 -*-
class Cms::ExpertsController < Cms::BaseController
  def index
    @experts = Expert.page(params[:page])
  end
  
  def show
    @expert = Expert.find(params[:id])
  end

  protected
    def expert_params
      params.require(:expert).permit!
    end
end
