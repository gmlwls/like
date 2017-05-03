class LikesController < ApplicationController
    before_action :set_user
    
    def create
        like = Like.find_by(user_id: @user.id, post_id: params[:post_id])
        if like.nil?
            Like.create(user_id: @user.id, post_id: params[:post_id])
        else
            like.destroy
        end
        
        redirect_to :back
    end
    
    private
    def set_user
        @user = User.find(session[:user_id])
    end
end
