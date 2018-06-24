class MessagesController < ApplicationController
  before_action :set_room

  def create
    @message = Message.new(message_params)
    @message.user = current_user
    if @message.save
      ActionCable.server.broadcast "messages_#{@message.chatroom_id}_channel",
                                   message: @message.content,
                                   user: @message.user.name,
                                   room: @message.room_id
      head :ok  # 空のコンテンツを表示
    else
    end
  end

  private
  def set_room
    @room = Room.find(params[:room_id])
  end

  def message_params
    params.require(:message).pemit(
      :content,
      :image
      ).merge(
      user_id: current_user.id,
      room_id: @room.id
      )
  end
end
