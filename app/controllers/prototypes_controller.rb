class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  def index

    @prototypes = Prototype.all
  end
  def new
    @prototype = Prototype.new
  end

  def create
      @prototype = Prototype.create(prototype_params)
    if @prototype.save
      redirect_to prototypes_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end
  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = Prototype.find(params[:id])
    prototype.update(prototype_params)
    redirect_to root_path
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
    @user = @prototype.user.name
  end

  private
  
  def prototype_params
    params.require(:prototype).permit( :image,:title,:catch_copy,:concept).merge(user_id: current_user.id)
  end

  #prototype_paramsというストロングパラメーターを定義し、createメソッドの引数に使用して、prototypeテーブルへ保存できるようにしました。
  
end
