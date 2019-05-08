# frozen_string_literal: true

require File.expand_path('../spec_helper.rb', __dir__)

RSpec.describe Mystique::App do
  it 'should greet' do
    get '/'

    expect(last_response).to be_ok
    expect(last_response.body).to eq('Hello World')
  end
end
