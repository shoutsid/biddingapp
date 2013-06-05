require 'spec_helper'

describe 'routing to events' do
  it 'routes GET /events/updates to events#updates' do
    expect(get: 'events/updates').to route_to(
      controller: 'events',
      action: 'updates'
    )
  end

  it 'routes GET /events/time_left to events#time_left' do
    expect(get: 'events/time_left').to route_to(
      controller: 'events',
      action: 'time_left'
    )
  end
end
