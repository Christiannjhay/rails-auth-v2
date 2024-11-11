class RoomsController < ApplicationController
  before_action :set_hotel
  before_action :set_room, only: [:edit, :update, :destroy]

  def index
    @rooms = @hotel.rooms
  end

  def new
    @room = @hotel.rooms.build
  end

  def create
    @room = @hotel.rooms.build(room_params)
    
    if @room.save
      flash[:notice] = "Room successfully added."
      redirect_to hotel_path(@hotel)
    else
      flash.now[:alert] = "Failed to add room."
      render :new
    end
  end

  


  def edit
  end

  def update
    if @room.update(room_params)
      flash[:notice] = "Room updated successfully."
      redirect_to hotel_path(@hotel)
    else
      flash.now[:alert] = "Failed to update room."
      render :edit
    end
  end

  def destroy
    @room.destroy
    flash[:notice] = "Room deleted successfully."
    redirect_to hotel_rooms_path(@hotel)
  end

  private

  def set_hotel
    @hotel = Hotel.find(params[:hotel_id])
  end

  def set_room
    @room = @hotel.rooms.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:hotel_id, :room_type, :description, :capacity, :price, amenities: [], media: [])
  end
  
end
