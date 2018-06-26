class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    logger.debug "1---------------------------"
    @message.user = current_user
    logger.debug "2---------------------------"
    logger.debug "#{message_params}"
    if @message.save
      ActionCable.server.broadcast "messages_#{@message.room_id}_channel",
                                   id: @message.id,
                                   message: @message[:content],
                                   image: @message.image,
                                   time: @message.created_at.to_s(:published_on),
                                   user: @message.user.name,
                                   room: @message.room_id
      Rails.logger.debug "ここまでOK"
      head :ok  # 空のコンテンツを表示
      # render :template => "rooms/show"
    else
    end
  end

  private

  def message_params
    logger.debug "ストロングパラメータだよ！"
    params.require(:message).permit(
      :content,
      :image,
      :room_id
      )
  end
end
