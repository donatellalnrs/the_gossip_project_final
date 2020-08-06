class SessionsController < ApplicationController
  def new 
    @user = User.new
  end 

  def create 
    user = User.find_by(email: params[:email])
    # on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe 
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Vous êtes bien connecté !"
      redirect_to gossips_path

    else
      flash.now[:danger] = "L'adresse email et le mot de passe ne concordent pas."
      render :new
    end 
  end 

  def destroy
    session.delete(:user_id)
    redirect_to gossips_path
  end 
end 