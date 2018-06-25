class MessagesController < ApplicationController
  before_action :set_room

  def create
    @message = Message.new(message_params)
    @message.user = current_user
    if @message.save
      ActionCable.server.broadcast "messages_#{@message.room_id}_channel",
                                   message: @message.content,
                                   user: @message.user.name,
                                   room: @message.room_id
      redirect_to room_path
      head :ok  # 空のコンテンツを表示
    else
    end
  end

  private

  def set_room
    logger.debug "loggerです！ #{params}"
    @room = Room.find(params[:message][:room_id])
  end

  def message_params
    logger.debug "ストロングパラメータだよ！ #{@room.id}"
    params.require(:message).permit(
      :content,
      :image,
      user_id: current_user.id,
      room_id: @room.id
      )
  end
end
