class CommentsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create]
  
  def index 
    @comments = Comment.all
  end 
  
  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
    @gossip = Gossip.find(params[:gossip_id])
  end 

  def create 
    @comment = Comment.new(content: params[:content])
    @comment.user_id = current_user.id
    @comment.gossip_id = params[:gossip_id]
    @comment.save
    redirect_to gossip_path(params[:gossip_id])
  end 

  def edit 
    @comment = Comment.find(params[:id]) 
    @gossip = Gossip.find(params[:gossip_id])
  end 
  
  def update 
    @comment = Comment.find(params[:id]) 
    redirect_to gossip_path(params[:gossip_id])
  end 

  def destroy
    @comment = Comment.find(params[:id]) 
    @comment.destroy 
    redirect_to gossip_path(params[:gossip_id])
  end 

  def post_params
    post_params = params.require(:comment).permit(:content)
  end 

   def authenticate_user
    unless current_user
      flash[:danger] = "Merci de vous connecter !"
      redirect_to new_session_path
    end
  end

end