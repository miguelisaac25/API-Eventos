class TicketsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[ index show ]
  before_action :set_ticket, only: %i[ show update destroy ]

  def index
    @tickets = Ticket.all
    render json: @tickets
  end

  def show
    render json: @ticket
  end

  def create
    @ticket = Ticket.new(ticket_params)
    authorize @ticket

    if @ticket.save
      render json: @ticket, status: :created, location: @ticket
    else
      render json: @ticket.errors, status: :unprocessable_entity
    end
  end

  private

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(:name, :price, :quantity, :event_id)
  end
end
