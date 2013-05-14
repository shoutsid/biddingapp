require 'spec_helper'
describe 'routing to bids' do
  
  it 'routes GET :category_id/items/:id/bids to bids#index' do
    expect(get: '/1/items/1/bids').to route_to(
      controller: 'bids',
      action: 'index',
      category_id: '1',
      item_id: '1'
    )
  end
  
  it 'routes GET :category_id/items/:id/bids/:id/ to bids#show' do
    expect(get: '/1/items/1/bids/2').to route_to(
      controller: 'bids',
      action: 'show',
      category_id: '1',
      item_id: '1',
      id: '2'
    )
  end
  
  it 'routes GET :category_id/items/:id/bids/new to bids#new' do
    expect(get: '/1/items/1/bids/new').to route_to(
      controller: 'bids',
      action: 'new',
      category_id: '1',
      item_id: '1'
    )
  end
  
  it 'routes DELETE :category_id/items/:id/bids/:id to bids#delete' do
    expect(delete: '/1/items/1/bids/2').to route_to(
      controller: 'bids',
      action: 'destroy',
      id: '2',
      category_id: '1',
      item_id: '1'
    )
  end
  
  it 'routes PATCH :category_id/items/:id/bids/:id to bids#update' do
    expect(patch: '/1/items/1/bids/2').to route_to(
      controller: 'bids',
      action: 'update',
      id: '2',
      category_id: '1',
      item_id: '1'
    )
  end

  it 'routes PUT :category_id/items/:id/bids/:id to bids#update' do
    expect(put: '/1/items/1/bids/2').to route_to(
      controller: 'bids',
      action: 'update',
      id: '2',
      category_id: '1',
      item_id: '1'
    )
  end

  it 'routes POST :category_id/items/:id/bids to bids#create' do
    expect(post: '/1/items/1/bids').to route_to(
      controller: 'bids',
      action: 'create',
      category_id: '1',
      item_id: '1'
    )
  end

end
