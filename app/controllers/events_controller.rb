class EventsController < ApplicationController

  before_filter :find_event, :only => [:show, :map]

  def index
    @events = Event.upcoming.soon.page(params[:page]).per(10)
  end

  def search
    if params[:q].blank? and params[:date].blank?
      index
    else
      @events = Event.search(params[:q]).upcoming(params[:date].try(:to_date)).soon.page(params[:page]).per(10)
    end
    render :index
  end

protected
  def find_event
    @event = Event.find(params[:id])
  end

end
