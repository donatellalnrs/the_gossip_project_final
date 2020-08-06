class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new 
    @user = User.new
  end 

  def create 
    @user = User.new(post_params)
    if params.require(:user)[:password] == params.require(:user)[:password]
      if @user.save # essaie de sauvegarder en base @user
        flash.now[:success] = "Votre compte a bien été créé !"
        session[:user_id] = @user.id
        redirect_to gossips_path
      else
        flash.now[:danger] = "L'email ou le mot de passe est invalide."
        render :new
      end 
    else 
      flash.now[:danger] = "Les mots de passe sont différents."
      render :new
    end 
  end 

  def post_params
    post_params = params.require(:user).permit(:email, :password, :first_name, :last_name, :description, :age, :password_confirmation, :city_id)
  end 
end
