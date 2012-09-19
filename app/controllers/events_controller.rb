class EventsController < ApplicationController

  def index
    @events = Event.upcoming.soon.page(params[:page]).per(10)
  end

end
