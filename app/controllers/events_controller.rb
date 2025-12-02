class EventsController < ApplicationController
  before_action :set_event, only: %i[ show update destroy ]
  skip_before_action :authenticate_request, only: %i[ index show ]

  def index
    @events = Event.all

    render json: @events
  end

  def show
    render json: @event
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user

    authorize @event

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_content
    end
  end

  def update
    authorize @event

    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_content
    end
  end

  def destroy
    authorize @event
    @event.destroy!
  end

  private

  def set_event
    @event = Event.find(params.expect(:id))
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_time, :end_time, :location)
  end
end
