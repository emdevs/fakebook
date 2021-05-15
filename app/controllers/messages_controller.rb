class MessagesController < ApplicationController
    #later, this needs to work for both private convo and chatroom later
    def create

        #make sure msgs cant be blank latter (db validation too)
        @message = current_user.messages.build(message_params)
        if @message.save
            @chatroom_id = params[:message][:messageable_id]
            @chatroom = Chatroom.find(@chatroom_id)
            @user = @message.user

            ChatroomChannel.broadcast_to(@chatroom, {
                user: @user,
                message: @message
                # img_path: @user.profile.attached_img
            })
        else
            flash[:msg] = "Something went wrong, couldn't send message."
        end
        #add broadcast msg (will ob only wokr for chatroom (not private convo), fix this later)
    end

    protected

    def message_params
        params.require(:message).permit(:message, :messageable_type, :messageable_id)
    end
end
