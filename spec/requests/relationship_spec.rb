# frozen_string_literal: true

require 'rails_helper'

describe Api::RelationshipsController, type: :request do
  # POST create
  describe 'POST #create' do
    before(:each) do
      @character1, @character2 = create_list(:character, 2)
    end

    # POST /api/characters/:character_id/relationships/
    it 'generates a new relationship on post' do
      headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

      body = {
        "character_to_id": @character1.id,
        "character_from_id": @character2.id
      }.to_json

      character_url = "/api/characters/#{@character1.id}/relationships"
      post character_url, headers: headers, params: body

      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:ok)
      expect(Relationship.all.count).to eq(1)
    end
  end

  # DELETE destroy
  describe 'DELETE #destroy' do
    before(:each) do
      @character1, @character2 = create_list(:character, 2)
      @relationship = create(:relationship, character_from_id: @character1.id, character_to_id: @character2.id)

      @non_relationship_id = 404
    end

    # DELETE /api/relationships/:id
    it 'removes db entry for a relationship' do
      headers = { 'ACCEPT' => 'application/json' }

      character_url = "/api/characters/#{@character1.id}/relationships"
      delete "#{character_url}/#{@relationship.id}", headers: headers

      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:ok)
      expect(Relationship.all.count).to eq(0)
    end

    # DELETE /api/relationships/:id
    it 'returns not found error if entry does not exist' do
      headers = { 'ACCEPT' => 'application/json' }

      character_url = "/api/characters/#{@character1.id}/relationships"
      delete "#{character_url}/#{@non_relationship_id}", headers: headers

      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:not_found)
    end
  end
end
