# -*- encoding : utf-8 -*-
class Frontend::ReviewsController < Frontend::BaseController
  before_filter :authenticate_expert
  before_filter :find_expert

  def handled
    @reviews = @expert.reviews.handled
  end

  def unhandled
    @reviews = @expert.reviews.unhandled
  end

  def update
    @review = @expert.reviews.find(params[:id])
    if @review.update(review_params)
      @review.update(operated_at: Time.now)
      redirect_to @review, notice: "评审信息提交成功，请点击左侧“未处理论文”继续进行评审"
    else
      render action: 'show'
    end
  end

  def show
    @review = @expert.reviews.find(params[:id])
  end

  protected
    def review_params
      params.require(:review).permit!
    end

    def find_expert
      @expert = Expert.find(session[:expert_id])
    end
end