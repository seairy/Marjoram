# -*- encoding : utf-8 -*-
class Frontend::RatingsController < Frontend::BaseController
  before_filter :authenticate_expert
  before_filter :find_expert

  def handled
    @ratings = @expert.ratings.handled
  end

  def unhandled
    @ratings = @expert.ratings.unhandled
  end

  def update
    @rating = @expert.ratings.find(params[:id])
    if @rating.update(rating_params)
      @rating.update(finished_at: Time.now)
      redirect_to @rating, notice: "评审信息提交成功，请点击左侧“未处理论文”继续进行评审"
    else
      render action: 'show'
    end
  end

  def show
    @rating = @expert.ratings.find(params[:id])
  end

  protected
    def rating_params
      params.require(:rating).permit!
    end

    def find_expert
      @expert = Expert.find(session[:expert_id])
    end
end