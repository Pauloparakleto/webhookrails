class IssuesController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

    def index
        @issues = Issue.all
        render json: @issues
    end

    def show
        @issue = Issue.find(params[:id])
        render json: @issue
    end

    def handle_record_not_found
        render json: "{status: 404, response: Content not found, id: #{params[:id]}}"
    end
end
