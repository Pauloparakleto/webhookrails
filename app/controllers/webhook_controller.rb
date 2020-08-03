class WebhookController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:receiver]

    def receiver
    #request.body.rewind
    data_json = JSON.parse request.body.read
    open_issues = data_json['issue']['number'].to_i
    puts "You found me"
    puts "I got some json. Open issue number: #{open_issues}."
    @issue = Issue.new
    @issue.id = open_issues
    @issue.number = open_issues
    @issue.save
    render body: nil
    end
end
