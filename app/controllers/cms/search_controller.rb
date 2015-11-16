# -*- encoding : utf-8 -*-
class Cms::SearchController < Cms::BaseController

  def create
    keyword = params[:keyword].strip
    @users = User.where("chinese_name LIKE '%#{keyword}%' OR foreign_name LIKE '%#{keyword}%' OR subject LIKE '%#{keyword}%'").page(params[:page])
    render 'result'
  end
end