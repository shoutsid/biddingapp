require 'spec_helper'

describe 'routing to categories' do

  it 'routes GET /:id to categories#show' do
    expect(get: '/1').to route_to(
      controller: 'categories',
      action: 'show',
      id: '1'
    )
  end

  it 'routes GET /new to categories#new' do
    expect(get: '/new').to route_to(
      controller: 'categories',
      action: 'new'
    )
  end

  it 'routes DELETE /:id to categories#delete' do
    expect(delete: '/1').to route_to(
      controller: 'categories',
      action: 'destroy',
      id: '1'
    )
  end

  it 'routes PATCH :id to categories#update' do
    expect(patch: '/1').to route_to(
      controller: 'categories',
      action: 'update',
      id: '1'
    )
  end

  it 'routes PUT /:id to categories#update' do
    expect(put: '/1').to route_to(
      controller: 'categories',
      action: 'update',
      id: '1'
    )
  end

  it 'routes POST / to categories#create' do
    expect(post: '/').to route_to(
      controller: 'categories',
      action: 'create'
    )
  end

end
