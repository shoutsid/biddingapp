require 'spec_helper'

describe 'routing to categories' do
  it 'routes GET /categories to categories#index ' do
    expect(get: '/categories').to route_to(
      controller: 'categories',
      action: 'index'
    )
  end

  it 'routes GET /categories/:id to categories#show' do
    expect(get: '/categories/1').to route_to(
      controller: 'categories',
      action: 'show',
      id: '1'
    )
  end

  it 'routes GET /categories/new to categories#new' do
    expect(get: '/categories/new').to route_to(
      controller: 'categories',
      action: 'new'
    )
  end

  it 'routes DELETE /categories/:id to categories#delete' do
    expect(delete: '/categories/1').to route_to(
      controller: 'categories',
      action: 'destroy',
      id: '1'
    )
  end

  it 'routes PATCH /categories/:id to categories#update' do
    expect(patch: '/categories/1').to route_to(
      controller: 'categories',
      action: 'update',
      id: '1'
    )
  end

  it 'routes PUT /categories/:id to categories#update' do
    expect(put: '/categories/1').to route_to(
      controller: 'categories',
      action: 'update',
      id: '1'
    )
  end

  it 'routes POST /categories to categories#create' do
    expect(post: '/categories').to route_to(
      controller: 'categories',
      action: 'create'
    )
  end

  context 'at root' do
    it 'routes GET /:id to categories#show' do
      expect(get: '/1').to route_to(
        controller: 'categories',
        action: 'show',
        id: '1'
      )
    end
  end
end
