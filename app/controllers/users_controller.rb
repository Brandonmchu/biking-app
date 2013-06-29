class UsersController < ApplicationController
  before_filter :signed_in_user, :only => [:index, :edit, :destroy]
  before_filter :correct_user,   :only => [:edit, :update]
  before_filter :admin_user,     :only => [:destroy]

def new
  @user = User.new
end

def create
  @user = User.new(params[:user])
  if @user.save
    sign_in @user
    flash[:success] = "You registered!"
    redirect_to home_path
  else
    render 'new'
  end
end

def show
  if User.find_by_id(params[:id])
    @user = User.find_by_id(params[:id])
  else
    flash[:error] = "not a real user"
    redirect_to home_path
  end
end

def edit
end

def update
  if @user.update_attributes(params[:user])
    sign_in @user
    flash[:success] = "Account settings updated"
    redirect_to @user
  else
    render 'edit'
  end
end

def index
  @users = User.all
end

def destroy
  @user = User.find_by_id(params[:id])
  @user.destroy
  flash[:success] = "#{@user.name} has been deleted"
  redirect_to root_path
end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end

end
