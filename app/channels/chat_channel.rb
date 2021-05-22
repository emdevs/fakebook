class ChatChannel < ApplicationCable::Channel
  def subscribed
    private_chat = Chat.find(params[:chat_id])
    stream_for private_chat
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
