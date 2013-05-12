require 'spec_helper'

describe 'routing to items' do
  it 'routes GET /items to items#index' do
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

  context 'categories' do  

    it 'routes GET /:id/items to items#index ' do
      expect(get: '/1/items').to route_to(
        controller: 'items',
        action: 'index',
        category_id: '1'
      )
    end

    it 'routes GET /:id/items/:id to items#show' do
      expect(get: '/1/items/1').to route_to(
        controller: 'items',
        action: 'show',
        id: '1',
        category_id: '1'
      )
    end

    it 'routes GET /:id/items/new to items#new' do
      expect(get: '/1/items/new').to route_to(
        controller: 'items',
        action: 'new',
        category_id: '1'
      )
    end

    it 'routes DELETE /:id/items/:id to items#delete' do
      expect(delete: '/1/items/1').to route_to(
        controller: 'items',
        action: 'destroy',
        id: '1',
        category_id: '1'
      )
    end

    it 'routes PATCH /:id/items/:id to items#update' do
      expect(patch: '/1/items/1').to route_to(
        controller: 'items',
        action: 'update',
        id: '1',
        category_id: '1'
      )
    end

    it 'routes PUT /:id/items/:id to items#update' do
      expect(put: '/1/items/1').to route_to(
        controller: 'items',
        action: 'update',
        id: '1',
        category_id: '1'
      )
    end

    it 'routes POST /:id/items to items#create' do
      expect(post: '/1/items').to route_to(
        controller: 'items',
        action: 'create',
        category_id: '1'
      )
    end
  end
end
