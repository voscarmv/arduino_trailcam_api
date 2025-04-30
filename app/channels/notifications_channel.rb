class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications_#{current_user.id}"
    # ActionCable.server.broadcast(
    #   "notifications_#{current_user.id}",
    #   message: "Subscribed to notifications_#{current_user.id}"
    # )
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
