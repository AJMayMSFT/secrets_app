class UsersController < ApplicationController
  def new
  end

  def create
  end

  def show
    @user=User.find(session[:user_id])
  end

  def login
    puts "whatever"
    puts params[:user]
    user = User.find_by_email(params[:user][:email])
    puts user
    if user && user.authenticate(params[:user][:password])
      session[:name]=user.name
      session[:user_id]=user.id
      redirect_to '/secrets'
    else
      flash[:log_errors] = "Your username or password is invalid"
      redirect_to '/'
    end
  end

  def register

    user = User.new(user_params)
    if user.valid?
      user.save
      session[:name]=user.name
      session[:user_id]=user.id
      redirect_to '/secrets'
    else
      puts user.errors.full_messages
      flash[:errors]=user.errors.full_messages
      redirect_to "/users/new"
    end
  end


  def logout
    reset_session
    redirect_to '/'
  end

  def like
    secret = Secret.find(params[:secret_id])
    if (secret.likes.find_by(user_id:session[:user_id]))
      secret.likes.find_by(user_id:session[:user_id]).destroy
    else
      Like.create(user_id:session[:user_id], secret_id:secret.id)
    end
    redirect_to '/secrets'
  end

private

def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end


end
