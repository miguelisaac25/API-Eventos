class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:login]

  def login
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      token = JsonWebTokenService.encode(user_id: @user.id, role: @user.role.name)
      time = Time.now + 24.hours.to_i

      render json: {
        token: token,
        exp: time.strftime("%m-%d-%Y %H:%M"),
        user: { id: @user.id, email: @user.email, role: @user.role.name },
      }, status: :ok
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end
