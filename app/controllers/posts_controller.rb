class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @post = Post.new
  end

  def index
    if params[:search]
      @posts = Post.search(params[:search]).order("created_at DESC")
    else
      @posts = Post.all
    end
    @posts = @posts.page(params[:page]).per(10)
  end

  def create
    post_params = params.require(:post).permit(:title, :body)
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: "aksuyfg"
    else
      flash[:alert] = "FAIL"
      render :new
    end
  end

  def show
    @comment = Comment.new
  end

  def edit
  end

  def update
    post_params = params.require(:post).permit(:title, :body)

    if @post.update post_params
      redirect_to @post, notice: "iahv"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "WAKA"
  end

  private

  def find_post
    @post = Post.find params[:id]
  end
end
