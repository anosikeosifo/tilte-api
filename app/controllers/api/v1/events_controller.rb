class Api::V1::EventsController < ApplicationController
  before_action :set_event, except: [:index, :create]

  respond_to :json
  def index
    events = Event.order(created_at: :desc).includes(:organizer)
    render json: {
      success: true,
      data: ActiveModel::Serializer::CollectionSerializer.new(events),
      message: "event listing successful",
      status: 200
    }
  end

  def create
    event = Event.new(event_params)

    if event.save
      render json: {
        success: true,
        data: ActiveModel::Serializer::CollectionSerializer.new([event]),
        message: "event creation successful",
        status: 200
      }
    end
  end

  def show
    return unless @event 
    render json: {
      success: true,
      data: ActiveModel::Serializer::CollectionSerializer.new([@event]),
      message: "",
      status: 200
    }
  end

  def update
    event = @event.find_by(id: params[:id])

    if event.update(event_params)
      render json: { success: true, data: event, message: "" }, status: 200, location: [:api, post]
      # render json: post, status: 200, location: [:api, post]
    else
      # render json: { errors: post.errors }, status: 422
      render json: { success: false, data: "", message: post.errors.full_messages.to_sentence }, status: 200, location: [:api, post]
    end
  end

  def report
  end

  def remove
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end
end
