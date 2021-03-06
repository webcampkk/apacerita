class EventsController < ApplicationController

  before_filter :find_event, :only => [:show, :map]
  before_filter :set_up_ayah, :only => [:new, :create]

  respond_to :html, :json, :atom

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    ayah_passed = @ayah.score_result(params[:session_secret], request.remote_ip)

    if @event.valid? and ayah_passed
      @event.save
      flash[:success] = "Event submitted! It will show up on the site once it's approved. Thanks!"
      redirect_to events_path
    else
      flash[:error] = "It seems that you are not human. Hmm..." unless ayah_passed
      render :new
    end
  end

  def index
    respond_to do |format|
      format.html do
        @events = Event.approved.upcoming.nearest_first.page(params[:page])
        respond_with(@events)
      end
      format.json do
        Gabba::Gabba.new("UA-2589718-11", "apacerita.my").page_view("JSON Request", "events.json") if Rails.env.production?
        @events = Event.approved.upcoming.nearest_first.to_json
        respond_with(@events)
      end
      format.atom do
        Gabba::Gabba.new("UA-2589718-11", "apacerita.my").page_view("ATOM Feed", "events.atom") if Rails.env.production?
        @events = Event.approved.upcoming.nearest_first
        respond_with(@events)
      end
    end
  end

  def show
    respond_to do |format|
      format.html do
        respond_with(@event)
      end
      format.json do
        Gabba::Gabba.new("UA-2589718-11", "apacerita.my").page_view("JSON Request", "events/#{@event.id}.json") if Rails.env.production?
        respond_with(@event)
      end
    end
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
                  :phone_number, :fax_number, :website, :email, :category_id,
                  :submitter_name, :submitter_email, :submitter_website)
  end

end
