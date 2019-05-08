# frozen_string_literal: true

require 'clubhouse2'

module Mystique
  # Clubhouse integration
  class ClubhouseIntegration
    def initialize(exception_message)
      @client = Clubhouse::Client.new(api_key: '5cd1f174-cd9f-4afd-b797-2fb32764c474')
      # @client = Clubhouse::Client.new(api_key: 'xxxx')
      @exception_message = exception_message
    end

    def create_story
      project.create_story(
        name: title,
        story_type: 'bug',
        description: description,
        labels: [client.label(id: 7062).to_h]
      )
    end

    private

    attr_accessor :client, :exception_message

    def project
      client.project(id: 5649)
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
