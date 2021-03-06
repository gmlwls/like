class MainController < ApplicationController
  before_action :set_user
  
  def create
  end
  
  def save
    Group.create(gp_name: params[:gp_name], 
                category: params[:category],
                creater: params[:creater],
                content: params[:content],
                password: params[:password])
    redirect_to '/main/mypage'
  end

  def view
    @list = Group.find(params[:id])
    @member = Member.where(group_id: params[:id])
    @post = Post.where(group_id: params[:id]).reverse
    
    session[:return_to] = request.fullpath
  end
  
  def mypage
    @username = ""
    unless session[:user_id].nil?
      @username = User.find(session[:user_id]).username
    end
    
    @list1 = Group.where(category: "study").reverse
    @list2 = Group.where(category: "talent").reverse
  end
  
  def membercreate
    @member = Member.create(group_id: params[:id], name: params[:name])
    redirect_to session[:return_to]
  end
  
  def search
    search = params[:search]
    # 검색어입력안하거나 바로들어갈때 처리
    if search.nil? || search.empty?
      @list=[]
    else
      @list = Group.where("creater LIKE ? OR gp_name LIKE ?", "%#{search}%", "%#{search}%")
    end
  end
  
  def list
    @id = params[:id]
  end
  
  def listcreate
    Post.create(group_id: params[:id], 
                title: params[:title],
                name: params[:name],
                content: params[:content])
    redirect_to session[:return_to]
  end
  
  def showpost
    @post = Post.find(params[:id])
    @comment = Comment.where(post_id: params[:id]).reverse
  end
  
  def commentcreate
    Comment.create(post_id: params[:id],
                   comment: params[:comment],
                   username: params[:username])
    redirect_to :back
  end

  private
  def set_user
    if session[:user_id].nil?
      redirect_to '/users/login'
    else
      @user = User.find(session[:user_id])
    end
  end
end
