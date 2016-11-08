class Api::GroupEventsController < ApplicationController

  before_action :find_group_event, only: [:show, :update, :destroy, :publish]

  def index
    @group_events = GroupEvent.published_and_visible.limit(10)
    render json: GroupEventSerializer.serialize(@group_events, is_collection: true)
  end

  def show
    render json: @group_event
  end

  def create
    @group_event = GroupEvent.new(group_event_attributes)

    if @group_event.save
      render json: GroupEventSerializer.serialize(@group_event), status: 201
    else
      render json: JSONAPI::Serializer.serialize_errors(@group_event.errors), status: 422
    end
  end

  def update
    @group_event = GroupEvent.find(params["id"])

    if @group_event.update_attributes(group_event_attributes)
      render json: GroupEventSerializer.serialize(@group_event), status: 200
    else
      render json: JSONAPI::Serializer.serialize_errors(@group_event.errors), status: 422
    end
  end

  def destroy
    @group_event.mark_as_deleted!
    render json: GroupEventSerializer.serialize(@group_event)
  end

  def publish
    if @group_event.publish!
      render json: GroupEventSerializer.serialize(@group_event)
    else
      render json: JSONAPI::Serializer.serialize_errors(@group_event.errors), status: 422
    end
  end

  private

  def find_group_event
    @group_event = GroupEvent.find(params[:id])
    render nothing: true, status: :not_found unless @group_event.present?
  end

  def group_event_attributes
    params.require(:data)
          .require(:attributes)
          .permit(:name, :description, :starts_at, :ends_at, :location)
  end

end
