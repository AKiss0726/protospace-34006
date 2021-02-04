class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_prototype, only: [:edit, :show, :update]
  before_action :move_to_index, only: [:edit]


  def index
    @user = User.all
    @prototypes = Prototype.all
  end

  def new
    @user = User.new
    @prototype = Prototype.new
  end

  def show
    #user = User.find(params[:id])
    #@name = user.name
    #@prototype = Prototype.find(params[:id])
    @comment = Comment.new
    #@comments = Comment.all
    @comments = @prototype.comments
    #@comments = @prototype.comments.includes(:user)
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path(@prototype)
    else
      @prototype = @prototype.includes(:user)
      render :new
    end
  end

  def edit
      #@prototype = Prototype.find(params[:id])
  end

  def update
      prototype = Prototype.find(params[:id])
      prototype.update(prototype_params)
      if prototype.save#(prototype_params)
        redirect_to root_path(@prototype)
      else
        render :edit
      end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index
    unless user_signed_in? && current_user == @prototye
      redirect_to action: :index
    end
  end

end
