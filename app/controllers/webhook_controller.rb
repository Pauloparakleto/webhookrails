class WebhookController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:receiver]

    def receiver
    #request.body.rewind
    data_json = JSON.parse request.body.read
    puts "You found me"
    render body: nil
    end
end
