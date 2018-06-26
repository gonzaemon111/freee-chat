class MessagesChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.debug "ここだゆう app/Channel/messages_channel.rb"
    logger.debug "#{params}"
    room = Room.find(params['room'])
    if current_user.can_access?(room)
      stream_from "messages_#{params['room']}_channel"
    else
      reject
    end
  end
end
