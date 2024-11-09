class UsersController < ApplicationController

  def new
    @user = User.new
  end
  
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    @user = User.find(params[:id])
    render json: @user, status: :ok
  end

  def create
    @user = User.new(user_params)
  
    if @user.save
      redirect_to login_path, notice: 'Account created successfully. Please log in.'
    else
      render :new
    end
  end

  # GET /users/:id/edit
  def edit
    @user = User.find(params[:id])
  end

  # PATCH/PUT /users/:id
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to home_path, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy

    render json: @user, status: :no_content
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :mobile, :password, :password_confirmation)
  end
  

end
