class EventsController < ApplicationController

  before_filter :find_event, :only => [:show, :map]
  respond_to :html

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.save
    respond_with(@event, :location => events_path)
  end

  def index
    @events = Event.approved.upcoming.soon.page(params[:page])
  end

  def search
    if params[:q].blank? and params[:date].blank? and params[:category].blank?
      index
    else
      @events = Event.search(params[:q]).approved.in_category(params[:category]).upcoming(params[:date].try(:to_date)).soon.page(params[:page])
    end
    render :index
  end

protected
  def find_event
    @event = Event.approved.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :venue, :start_date, :end_date, :start_time, :end_time,
                  :longitude, :latitude, :description, :organizer, :contact_person,
                  :phone_number, :fax_number, :website, :email, :category_id)
  end

end
