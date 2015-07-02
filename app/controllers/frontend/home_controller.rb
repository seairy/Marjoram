# -*- encoding : utf-8 -*-
class Frontend::HomeController < Frontend::BaseController
  def index
    @posts = Post.visible.latest
  end
end