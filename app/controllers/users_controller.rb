class UsersController < ApplicationController
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
      redirect_to root_path
    else
      render 'new'
    end
  end

def edit 
  @user = User.find(params[:id])
end

def update 
  @user= User.find(params[:id])
  if @user.update(user_params)
      flash[:success] = "Edit Successful"
      redirect_to root_path
  else
      render 'edit'
  end
end

def show
  @user=User.find(params[:id])
end

def post_index

   @user= User.find(params[:id])
   @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
   render :layout => false , :except => :view

end

  private
    def user_params
      params.require(:user).permit(:username ,:email, :password)
    end
end
