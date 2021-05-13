class MessagesController < ApplicationController
    #later, this needs to work for both private convo and chatroom later
    def create

        #make sure msgs cant be blank latter (db validation too)
        @message = current_user.messages.build(message_params)
        if @message.save
        else
            flash[:msg] = "Something went wrong, couldn't send message."
        end
    end

    protected

    def message_params
        params.require(:message).permit(:message, :messageable_type, :messageable_id)
    end
end
