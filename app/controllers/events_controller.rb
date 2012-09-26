class EventsController < ApplicationController

  before_filter :find_event, :only => [:show, :map]
  before_filter :set_up_ayah, :only => [:new, :create]

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    ayah_passed = @ayah.score_result(params[:session_secret], request.remote_ip)

    if @event.valid? and ayah_passed
      @event.save
      redirect_to events_path
    else
      render :new
    end
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

  def set_up_ayah
    @ayah = AYAH::Integration.new(SystemPreferences.ayah_publisher_key, SystemPreferences.ayah_scoring_key)
  end

  def event_params
    params.require(:event).permit(:name, :venue, :start_date, :end_date, :start_time, :end_time,
                  :longitude, :latitude, :description, :organizer, :contact_person,
                  :phone_number, :fax_number, :website, :email, :category_id)
  end

end
