class OnlineChannel < ApplicationCable::Channel
  def subscribed
    current_user.status.update(online: true)
    ActionCable.server.broadcast("online_channel", { user_id: current_user.id, online: true })
    
    stream_from "online_channel"
  end

  def unsubscribed
    current_user.status.update(online: false)
    ActionCable.server.broadcast("online_channel", { user_id: current_user.id, online: false })
  end
end
