class UserMailer < ApplicationMailer
    default from: "notifications@fakebook.com"

    def welcome_email(params)
        @user = params[:user]
        @url = "http://localhost:3000/"
        mail(to: @user[:email], subject: "Welcome to Fakebook!")
    end
end
