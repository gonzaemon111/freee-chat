class RoomChannel < ApplicationCable::Channel
  # サーバーサイドの処理を受け持つチャンネル
  # クライアント(ユーザ)がこのチャネルの購読側になると
  # このコードが呼び出される
  # コンシューマー(ユーザ)の接続はサブスクリプション（Subscription: 購読）と呼ばれます。
  def subscribed
    stream_from "room_channel_#{params[:room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak
    ActionCable.server.broadcast 'room_channel', message: data['message']
  end
end
