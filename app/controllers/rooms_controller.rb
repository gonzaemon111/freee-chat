class RoomsController < ApplicationController
  before_action :set_room, only: :update
  def index
  end

  def new
    @room = Room.new
    @room.users << current_user
  end

  def create
    @room = Room.new(room_params)
    @room.users << current_user

    if @room.save
      redirect_to rooms_path(@room)
      flash[:notice] = 'roomができました。'
    else
      render :new
    end
  end

  def update
  end

  private
  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(
      :name,
      user_ids: []
    )
  end
end
