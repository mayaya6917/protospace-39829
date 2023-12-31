class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :new]
  before_action :move_to_index, except: [:index, :show]
  def index
    @prototypes = Prototype.all
  end

  def new
    redirect_to new_user_session_path unless user_signed_in?
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)

    if @prototype.save
      redirect_to root_path, notice: 'Prototype was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    redirect_to root_path unless user_signed_in? && current_user == @prototype.user
  end

  def update
    @prototype = Prototype.find(params[:id])

    if @prototype.update(prototype_params)
      redirect_to prototype_path(params[:id]), notice: 'Prototype was successfully created.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
