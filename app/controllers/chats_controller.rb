class ChatsController < ApplicationController
    #Private chat controller
    def index
        @chat_partners = current_user.chat_partners
    end

    def show
        @chat = Chat.find(params[:id])
        @messages = @chat.messages.includes(:user).order("created_at ASC")
        @message = @chat.messages.new

        respond_to do |format|
            format.js {render layout: false}
        end
    end
end
