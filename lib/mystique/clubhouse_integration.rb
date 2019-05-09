# frozen_string_literal: true

require 'clubhouse2'

module Mystique
  # Clubhouse integration
  class ClubhouseIntegration
    def initialize(exception_message)
      @client = Clubhouse::Client.new(api_key: ENV['CLUBHOUSE_TOKEN'])
      @exception_message = exception_message
    end

    def create_story
      project.create_story(
        name: title,
        story_type: 'bug',
        description: description,
        labels: [client.label(id: ENV['LABEL_AIRBRAKE_ID'].to_i).to_h]
      )
    end

    private

    attr_accessor :client, :exception_message

    def project
      client.project(id: ENV['PROJECT_CLUBHOUSE_ID'].to_i)
    end

    def title
      "[Airbrake][#{exception_message.environment}] - #{exception_message.error_message}"
    end

    def description
      <<~DESCRIPTION
        **Message:** #{exception_message.error_message}
        **Where:** #{exception_message.error_class}
        **File:** #{exception_message.file}#{exception_message.line_number}
        **First occurred at:** #{exception_message.first_occurred_at}
        **Last occurred at:** #{exception_message.last_occurred_at}

        [View on Airbrake](#{exception_message.error_url})
      DESCRIPTION
    end
  end
end
