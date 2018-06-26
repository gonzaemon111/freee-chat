class RoomsController < ApplicationController
  before_action :set_room, only: [:edit , :update , :show , :destroy]
  def index
  end

  def new
    # Roomクラスのインスタンス生成する。
    @room = Room.new
    @room.users << current_user
  end

  def show
    # Messageクラスのインスタンスを生成する。
    @message = Message.new
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to rooms_path
      flash[:notice] = "Room of #{@room} creates!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @room.update(set_param)
      flash[:notice] = "Room of #{@room} updates!"
      render :index
    else
      flash[:notice] = "Couldn't update room..."
    end
  end

  def destroy
    @room.destroy
    flash[:notice] = "Room of #{@room} destroys."
    render :index
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
