# frozen_string_literal: true

require 'rack/test'
require 'rspec'
require 'pry'

require File.expand_path '../lib/mystique', __dir__

ENV['RACK_ENV'] = 'test'

# RSpec
module RSpecMixin
  include Rack::Test::Methods

  def app
    Mystique::App.new
  end
end

RSpec.configure { |c| c.include RSpecMixin }
