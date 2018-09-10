class UsersController < ApplicationController
 def new
   @user = User.new
 end

 def index
   @users = User.all
   @blogs = Blog.page(params[:page]).per(5)
   if  @users.find(12) == current_user
   else
     redirect_to root_path
   end

 end

 def check
   @user = User.find(params[:user_id])
   @user.approval = true
   @user.save(validate: false)
   redirect_to user_path(@user.id)
 end
 def create
   @user = User.new(user_params)
   if @user.save

     redirect_to user_path(@user.id)
   else
     render 'new'
   end
 end

 def show
   @user = User.find(params[:id])
   @favorite_blogs = @user.favorite_blogs
 end

 def favorite
   @user = current_user
   @favorite_blogs = @user.favorite_blogs
 end

 private

 def user_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon, :icon_cache)
 end
end
