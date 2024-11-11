class HotelsController < ApplicationController
  include AdminSessionHelper

  before_action :require_admin

  def show
    @hotel = Hotel.find(params[:id])
  end
  
  def new
    @hotel = Hotel.new
  end

  def create
    @hotel = Hotel.new(hotel_params)
    if @hotel.save
      flash[:notice] = "Hotel successfully created."
      redirect_to admin_home_view_path
    else
      flash.now[:alert] = "Failed to create hotel."
      render :new
    end
  end

  def edit
    @hotel = Hotel.find(params[:id])
  end

  def update
    @hotel = Hotel.find(params[:id])
    if @hotel.update(hotel_params)
      flash[:notice] = "Hotel updated successfully."
      redirect_to admin_home_view_path
    else
      flash.now[:alert] = "Failed to update hotel."
      render :edit
    end
  end

  private

  def hotel_params
    params.require(:hotel).permit(:name, :location, :description, amenities: [], media: [])
  end
  

end
