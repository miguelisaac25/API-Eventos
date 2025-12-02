class RegistrationsController < ApplicationController
  before_action :set_registration, only: %i[ show update destroy ]

  def index
    @registrations = Registration.all
    render json: @registrations
  end

  def create
    @registration = Registration.new(registration_params)
    @registration.user = current_user

    authorize @registration

    if @registration.save
      render json: @registration, status: :created, location: @registration
    else
      render json: @registration.errors, status: :unprocessable_entity
    end
  end

  private

  def set_registration
    @registration = Registration.find(params[:id])
  end

  def registration_params
    params.require(:registration).permit(:status, :ticket_id)
  end
end
