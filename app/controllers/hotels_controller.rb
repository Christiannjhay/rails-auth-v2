class HotelsController < ApplicationController
  include AdminSessionHelper

  before_action :require_admin

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

  private

  def hotel_params
    params.require(:hotel).permit(:name, :location, :description, amenities: [], media: [])
  end
  

end
