class Api::V1::EventCategoriesController < ApplicationController
  respond_to :json


  def home
    event_categories = EventCategory.for_home_view
    render json: { success: true, data: ActiveModel::Serializer::CollectionSerializer.new(event_categories), message: "" }
  end
end
