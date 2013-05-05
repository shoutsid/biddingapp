require 'spec_helper'
describe 'routing to bids' do
  
  it 'routes GET /items/:id/bids to bids#index' do
    expect(get: '/items/1/bids').to route_to(
      controller: 'bids',
      action: 'index',
      item_id: '1'
    )
  end
  
  it 'routes GET /items/:id/bids/:id/ to bids#show' do
    expect(get: '/items/1/bids/2').to route_to(
      controller: 'bids',
      action: 'show',
      item_id: '1',
      id: '2'
    )
  end
  
  it 'routes GET /items/:id/bids/new to bids#new' do
    expect(get: '/items/1/bids/new').to route_to(
      controller: 'bids',
      action: 'new',
      item_id: '1'
    )
  end
  
  it 'routes DELETE /items/:id/bids/:id to bids#delete' do
    expect(delete: '/items/1/bids/2').to route_to(
      controller: 'bids',
      action: 'destroy',
      id: '2',
      item_id: '1'
    )
  end
  
  it 'routes PATCH /items/:id/bids/:id to bids#update' do
    expect(patch: '/items/1/bids/2').to route_to(
      controller: 'bids',
      action: 'update',
      id: '2',
      item_id: '1'
    )
  end

  it 'routes PUT /items/:id/bids/:id to bids#update' do
    expect(put: '/items/1/bids/2').to route_to(
      controller: 'bids',
      action: 'update',
      id: '2',
      item_id: '1'
    )
  end

  it 'routes POST /items/:id/bids to bids#create' do
    expect(post: '/items/1/bids').to route_to(
      controller: 'bids',
      action: 'create',
      item_id: '1'
    )
  end

end
