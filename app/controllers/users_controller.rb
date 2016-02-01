class UsersController < ApplicationController
  
  before_action :set_user, only: [:edit, :update, :show, :destroy, :post_index]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: :destroy

  def new
    @user=User.new
  end

  def index
    @users =  User.paginate(page: params[:page], per_page: 5)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Signup Successful"
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

def edit 
end

def update 
  if @user.update(user_params)
      flash[:success] = "Edit Successful"
      redirect_to root_path
  else
      render 'edit'
  end
end

def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
end

def destroy
  u_name = @user.username
  a_count = @user.articles.count
  @user.destroy
  flash[:danger] = "User: #{u_name} and #{pluralize(a_count, "Article")} deleted"
  redirect_to users_path
end

def post_index
   @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
   render :layout => false , :except => :view
end

  private
    def user_params
      params.require(:user).permit(:username ,:email, :password)
    end
    def set_user
      @user= User.find(params[:id])
    end
    def require_same_user
      if current_user != @user && !current_user.admin?
        flash[:danger] = "You do not have permission to access this page"
        redirect_to root_path
      end
    end
    def require_admin
      if logged_in? && !current_user.admin?
        flash[:danger] = "Admin permissions required"
        redirect_to root_path
      end
    end
    
end
