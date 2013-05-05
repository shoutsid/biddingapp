require 'spec_helper'
describe 'routing to items' do
  it 'routes GET /items to items#index ' do
    expect(get: '/items').to route_to(
      controller: 'items',
      action: 'index'
    )
  end
  
  it 'routes GET /items/:id to items#show' do
    expect(get: '/items/1').to route_to(
      controller: 'items',
      action: 'show',
      id: '1'
    )
  end
  
  it 'routes GET /items/new to items#new' do
    expect(get: '/items/new').to route_to(
      controller: 'items',
      action: 'new'
    )
  end
  
  it 'routes DELETE /items/:id to items#delete' do
    expect(delete: '/items/1').to route_to(
      controller: 'items',
      action: 'destroy',
      id: '1'
    )
  end
  
  it 'routes PATCH /items/:id to items#update' do
    expect(patch: '/items/1').to route_to(
      controller: 'items',
      action: 'update',
      id: '1'
    )
  end

  it 'routes PUT /items/:id to items#update' do
    expect(put: '/items/1').to route_to(
      controller: 'items',
      action: 'update',
      id: '1'
    )
  end

  it 'routes POST /items to items#create' do
    expect(post: '/items').to route_to(
      controller: 'items',
      action: 'create'
    )
  end
end
