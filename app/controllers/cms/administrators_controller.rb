# -*- encoding : utf-8 -*-
class Cms::AdministratorsController < Cms::BaseController
  
  def index
    @administrators = Administrator.paginate page: params[:page]
  end
  
  def show
    @administrator = Administrator.find(params[:id])
  end
  
  def new
    @administrator = Administrator.new
  end
  
  def edit
    @administrator = Administrator.find(params[:id])
  end
  
  def create
    @administrator = Administrator.new(administrator_params)
    if @administrator.save
      redirect_to [:cms, @administrator], notice: '创建成功！'
    else
      render action: 'new'
    end
  end
  
  def update
    @administrator = Administrator.find(params[:id])
    if @administrator.update(administrator_params)
      redirect_to [:cms, @administrator], notice: '更新成功！'
    else
      render action: 'edit'
    end
  end

  protected
  def administrator_params
    params.require(:administrator).permit(:account, :password, :password_confirmation, :name, :available)
  end
end
