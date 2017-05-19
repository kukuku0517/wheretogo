class PostController < ApplicationController
   before_action :authenticate_user!
   def index
    @post = current_user.posts
  end

  def create
    post = Post.new
    post.user_id = current_user.id
    post.save
    
    redirect_to show_path(post.id)
  end

  def show
    
  end
  
  def result
  end
  
end
