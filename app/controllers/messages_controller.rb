require @local_time

class MessagesController < ApplicationController
    
    def create
        @message = current_user.messages.build(message_params)
        if @message.save
            @user = @message.user
            @msgable_id = params[:message][:messageable_id]
            @msgable_type = params[:message][:messageable_type]

            #Chat or Chatroom object.
            @messageable = @msgable_type.classify.constantize.find(@msgable_id)
            make_broadcast(@msgable_type, @messageable)
        else
            flash[:msg] = "Something went wrong, couldn't send message."
        end
    end

    def make_broadcast(channel_name, messagable) 
        channel = (channel_name.classify + "Channel").constantize

        channel.broadcast_to(messagable, {
            user: @user,
            message: @message,
            datetime: @message.created_at,
        })
    end

    protected

    def message_params
        params.require(:message).permit(:message, :messageable_type, :messageable_id)
    end
end

