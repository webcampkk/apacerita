class EventsController < ApplicationController

  before_filter :find_event, :only => [:show, :map]

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

end
