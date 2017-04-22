class UsersController < ApplicationController
  def login
  end

  def login_process
    u = User.where(username: params[:username],
                   password: params[:password]).take
    if u.nil?
      redirect_to '/'
    else
      session[:user_id] = u.id
      redirect_to '/main/mypage'      
    end
    
  end

  def new
  end
  
  def join_process
    u = User.new
    u.username = params[:username]
    u.password = params[:password]
    u.save
    redirect_to '/users/login'
  end
  
  def logout
    reset_session
    redirect_to '/'
  end
end
