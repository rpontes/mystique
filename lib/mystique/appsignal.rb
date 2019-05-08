# frozen_string_literal: true

module Mystique
  # AppSignal
  class Appsignal
    Exception = Struct.new(:pretext, :attachments)

    def initialize(response)
      @response = response
    end
  end
end
