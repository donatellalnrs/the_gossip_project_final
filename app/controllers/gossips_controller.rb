class GossipsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index 
    @gossips = Gossip.all
    if current_user == nil 
      @current_user_id = 0
    else 
      @current_user_id = current_user.id
    end
  end 
  
  def show
    @gossip = Gossip.find(params[:id])
    @user = @gossip.user
    @comments = Comment.where(gossip_id: params[:id])
    if current_user == nil 
      @current_user_id = 0
    else 
      @current_user_id = current_user.id
    end
  end

  def new 
    @gossip = Gossip.new
    @tags = Tag.all
  end 

  def create 
    @gossip = Gossip.new(post_params)
    @gossip.user_id = current_user.id
    if @gossip.save # essaie de sauvegarder en base @gossip
      redirect_to gossip_path(@gossip.id)
    else
      @tags = Tag.all
      render :new
    end
  end 

  def edit 
    @gossip = Gossip.find(params[:id])
  end 

  def update 
    @gossip = Gossip.find(params[:id])
    @gossip.user_id = current_user.id 
    if @gossip.update(post_params)
      redirect_to gossip_path(@gossip.id)
    else
      render :edit
    end
  end 
  
  def post_params
    post_params = params.require(:gossip).permit(:title, :content)
  end 

  def destroy
    @gossip = Gossip.find(params[:id]) 
    @gossip.destroy 
    redirect_to gossips_path
  end 

  def authenticate_user
    unless current_user
      flash[:danger] = "Merci de vous connecter !"
      redirect_to new_session_path :notice => "Merci de vous connecter"
    end
  end

  def correct_user
    unless current_user.id == Gossip.find(params[:id])[:user_id]
      flash[:danger] = "Vous ne pouvez pas réaliser cette action !"
      redirect_to gossips_path
    end 
  end 

end
