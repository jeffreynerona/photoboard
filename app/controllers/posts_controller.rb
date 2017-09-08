class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def new
  	@post = Post.new
  end

  def index
  	@posts = Post.all 
  end

  def show
  	@post = Post.find(params[:id])
  end

  def create
  	@post = Post.new(permit_post)
    @post.user_id = current_user.id
  		if @post.save
  			flash[:success] = "Success!"
  			redirect_to post_path(@post)
  		else
  			flash[:error] = @post.errors.full_messages
  			redirect_to new_post_path
  		end
    end
  private
  	def permit_post
  		params.require(:post).permit(:image,:description)
  	end
end
