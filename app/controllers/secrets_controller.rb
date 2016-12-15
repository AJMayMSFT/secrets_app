class SecretsController < ApplicationController
  def index
    @secrets = Secret.all
  end

  def create
    secret = Secret.new(secret:params[:secret_text], user_id:session[:user_id])
    if secret.valid?
      secret.save
    else
      flash[:secret_errors]=secret.errors.full_messages
    end
      redirect_to "/users/#{session[:user_id]}"
  end

  def destroy
    Secret.find(params[:secret_id]).destroy
    redirect_to '/secrets'
  end
end
