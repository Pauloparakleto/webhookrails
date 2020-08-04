class EventsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

    def index
        @events = Event.all
        render json: @events
    end

    def show
        @event = Event.find(params[:id])
        render json: @event
    end

    def handle_record_not_found
        render json: "{status: 404, response: Content not found}"
    end
    #def issue_events
        #@issue = Issue.find(params[:issue_id])
        #@events = Event.all
    #end
end
