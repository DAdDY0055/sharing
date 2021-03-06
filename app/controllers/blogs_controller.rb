class BlogsController < ApplicationController
  before_action :set_blog, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :user_approval


  def index
    @blogs = Blog.page(params[:page]).per(100).order("id DESC")
    # @count = Comment.where(blog.id:@blog.id).count
    # @user = User.find(1).id
    # @blog = Blog.all
    # # @favorite = current_user.favorites.find_by(blog_id: @blog.id)
    # @comments = @blog.comments
    # @comment = @blog.comments.build
    # @comment = Comment.new



  end

  def show
    @blog = Blog.find(params[:id])
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
    @comments = @blog.comments
    @comment = @blog.comments.build
    @comment = Comment.new
  end

  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def create

    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if @blog.save
      redirect_to blogs_path, notice: "情報を登録しました！"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "情報を編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"情報を削除しました！"
  end

  def confirm
   @blog = Blog.new(blog_params)
   @blog.user_id = current_user.id
   render :new if @blog.invalid?
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content,:image, :image_cache, :url)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def set_user
    redirect_to blogs_path unless current_user.id == @blog.user_id

  end

  def user_approval
    unless current_user && current_user.approval == true
      redirect_to root_path
    end
  end
end
