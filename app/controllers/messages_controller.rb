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
        #ex. "Chatroom" < messagable_type
        channel = (channel_name.classify + "Channel").constantize
        #assumes successfuly converts Chatroom to ChatroomChannel
        channel.broadcast_to(messagable, {
            user: @user,
            current_user_id: current_user.id,
            message: @message,
            datetime: @message.datetime
        })
    end

    protected

    def message_params
        params.require(:message).permit(:message, :messageable_type, :messageable_id)
    end
end



    # def create
    #     @message = current_user.messages.build(message_params)
    #     if @message.save
    #         @chatroom_id = params[:message][:messageable_id]
    #         @chatroom = Chatroom.find(@chatroom_id)
    #         @user = @message.user

    #         ChatroomChannel.broadcast_to(@chatroom, {
    #             user: @user,
    #             message: @message,
    #             #cant access class method in js, manully enter datetime
    #             datetime: @message.datetime
    #             # img_path: @user.profile.attached_img
    #         })
    #     else
    #         flash[:msg] = "Something went wrong, couldn't send message."
    #     end
    #     #add broadcast msg (will ob only wokr for chatroom (not private convo), fix this later)
    # end