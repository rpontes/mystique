# frozen_string_literal: true

module Mystique
  # AppSignal
  class Airbrake
    ExceptionMessage = Struct.new(
      :id,
      :error_message,
      :error_class,
      :file,
      :line_number,
      :environment,
      :first_occurred_at,
      :last_occurred_at,
      :error_url
    )

    def initialize(request_parsed)
      @request_parsed = request_parsed
    end

    def build
      error = request_parsed['error']

      ExceptionMessage.new(
        error['id'],
        error['error_message'],
        error['error_class'],
        error['file'],
        error['line_number'],
        error['environment'],
        error['first_occurred_at'],
        error['last_occurred_at'],
        request_parsed['airbrake_error_url']
      )
    end

    private

    attr_accessor :request_parsed
  end
end
