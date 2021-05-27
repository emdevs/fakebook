class UserMailer < ApplicationMailer
    default from: "notifications@fakebook.com"

    def welcome_email(params)
        @user = params[:user]
        @url = "https://fakebook-site.herokuapp.com/"
        mail(to: @user[:email], subject: "Welcome to Fakebook!")
    end
end
