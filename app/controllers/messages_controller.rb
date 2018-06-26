class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    @message.user = current_user
    if @message.save
      ActionCable.server.broadcast "messages_#{@message.room_id}_channel",
                                   id: @message.id,
                                   message: @message[:content],
                                   time: @message.created_at.to_s(:published_on),
                                   user: @message.user.name,
                                   room: @message.room_id
      head :ok  # 空のコンテンツを表示
    else
      raise "チャンネル生成に失敗しました。"
    end
  end

  private

  def message_params
    params.require(:message).permit(
      :content,
      :room_id
      )
  end
end
