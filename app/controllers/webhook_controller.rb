class WebhookController < ApplicationController
    #skip_before_action :verify_authenticity_token, only: [:receiver]

    def receiver
    #request.body.rewind
    @data_json = JSON.parse request.body.read
    @issue_action = @data_json['action']
    puts "The action for this issue is: #{@issue_action}."
    @issue_number = @data_json['issue']['number'].to_i
    puts "The issue number: #{@issue_number}."
    if @issue_action == 'opened'
        puts "This is an open action. You must insert data into Issue table."        
        puts "Issue opened number: #{@issue_number}."
        create_issue
        create_event

    else
        puts "This is a close or reopen action. You must insert data into Event table."
        puts "The foreing key is #{@issue_number}."
        puts "The event (action) name is: #{@issue_action}."
        create_event
    end
    render body: nil
    end

    def create_issue
        @issue = Issue.new
        @issue.id = @issue_number
        @issue.number = @issue_number
        if @issue.save
            puts "Saved successfully issue on database!"
        end    
    end

    def create_event
        @event = Event.new
        @event.issue_id = @issue_number
        @event.name = @issue_action
        if @event.save
            puts "Saved successfully event on database!"
        end 
    end
end
