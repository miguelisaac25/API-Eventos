class UserMailer < ApplicationMailer
  default from: "notifications@eventsapi.com"

  def welcome_email
    @user = params[:user]
    @url = "http://localhost:3000/auth/login"

    mail(to: @user.email, subject: "Bem-vindo ao Sistema de Eventos!")
  end
end
