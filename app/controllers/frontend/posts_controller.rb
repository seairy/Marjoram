# -*- encoding : utf-8 -*-
class Frontend::PostsController < Frontend::BaseController
  def index
    @posts = Post.visible.latest.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end
end