# frozen_string_literal: true

require File.expand_path('../spec_helper.rb', __dir__)
require 'json'

RSpec.describe 'Airbrake webhook' do
  before do
    @incident_json = File.read(File.expand_path('../fixtures/airbrake.json', __dir__))
  end

  describe 'POST /airbrake' do
    it 'receive exception incident' do
      post '/airbrake', @incident_json, headers: { 'ACCEPT' => 'application/json' }

      expect(last_response.status).to eq 204
    end
  end
end
