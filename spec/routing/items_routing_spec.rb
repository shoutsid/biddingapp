require 'spec_helper'

describe 'routing to items' do

    it 'routes GET /:category_id/items to items#index ' do
      expect(get: '/1/items').to route_to(
        controller: 'items',
        action: 'index',
        category_id: '1'
      )
    end

    it 'routes GET /:category_id/items/:id to items#show' do
      expect(get: '/1/items/1').to route_to(
        controller: 'items',
        action: 'show',
        id: '1',
        category_id: '1'
      )
    end

    it 'routes GET /:category_id/items/new to items#new' do
      expect(get: '/1/items/new').to route_to(
        controller: 'items',
        action: 'new',
        category_id: '1'
      )
    end

    it 'routes DELETE /:category_id/items/:id to items#delete' do
      expect(delete: '/1/items/1').to route_to(
        controller: 'items',
        action: 'destroy',
        id: '1',
        category_id: '1'
      )
    end

    it 'routes PATCH /:category_id/items/:id to items#update' do
      expect(patch: '/1/items/1').to route_to(
        controller: 'items',
        action: 'update',
        id: '1',
        category_id: '1'
      )
    end

    it 'routes PUT /:category_id/items/:id to items#update' do
      expect(put: '/1/items/1').to route_to(
        controller: 'items',
        action: 'update',
        id: '1',
        category_id: '1'
      )
    end

    it 'routes POST /:category_id/items to items#create' do
      expect(post: '/1/items').to route_to(
        controller: 'items',
        action: 'create',
        category_id: '1'
      )
    end
end
