# -*- encoding : utf-8 -*-
class Cms::HotelsController < Cms::BaseController
  def index
    @hotels = Hotel.all
  end
end
