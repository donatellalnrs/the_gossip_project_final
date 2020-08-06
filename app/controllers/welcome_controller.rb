class WelcomeController < ApplicationController
  def show
    @user_entry = params[:user_entry]
  end
end
