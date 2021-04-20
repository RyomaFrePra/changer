class PostsController < ApplicationController
  before_action :authenticate_user!,except: [:index]
  before_action :set_post,except:[:index,:new,:create]
  before_action :user_check,only:[:edit]
  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_stp)
    redirect_to root_path
  end

  def edit

  end

  def update
    if @post.update(post_stp)
      return redirect_to root_path
    else 
      render 'edit'
    end
  end


  def destroy
    if @post.destroy
      redirect_to root_path
    else
      render 'edit'
    end
  end
  
  def post_stp
    params.require(:post).permit(:text).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def user_check
    if current_user != @post.user
      redirect_to root_path
    end
  end

end