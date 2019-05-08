# frozen_string_literal: true

require 'sinatra/base'
require 'json'

require './lib/mystique/clubhouse_integration'
require './lib/mystique/airbrake'

module Mystique
  # Mystique main app
  class App < Sinatra::Base
    get '/' do
      'Hello World'
    end

    post '/airbrake' do
      status 204

      begin
        request_parsed = JSON.parse(request.body.read)
        airbrake_exception = Airbrake.new(request_parsed).build

        ClubhouseIntegration.new(airbrake_exception).create_story
      rescue Clubhouse::ClubhouseAPIError
        status 400
      end
    end

    # When we change to use Appsignal as our error monitor.
    post '/appsignal' do
      status 204
    end
  end
end
