class EventsController < ApplicationController

  before_filter :find_event, :only => [:show, :map]

  def index
    @events = Event.upcoming.soon.page(params[:page]).per(10)
  end

  def search
    @events = Event.upcoming.soon.page(params[:page]).per(10)
    render :index
  end

protected
  def find_event
    @event = Event.find(params[:id])
  end

end
