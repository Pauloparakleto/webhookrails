class EventsController < ApplicationController
    def index
        @events = Event.all
        render json: @events
    end

    def show
        @event = Event.find(params[:id])
        render json: @event
    end

    #def issue_events
        #@issue = Issue.find(params[:issue_id])
        #@events = Event.all
    #end
end
