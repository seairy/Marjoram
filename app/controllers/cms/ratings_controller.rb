# -*- encoding : utf-8 -*-
class Cms::RatingsController < Cms::BaseController
  def show
    @rating = Rating.find(params[:id])
  end
end
