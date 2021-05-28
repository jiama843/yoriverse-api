# frozen_string_literal: true

require 'rails_helper'

describe Api::CharactersController, type: :request do
  # GET #show
  describe 'GET #show' do
    # GET /api/characters
    it 'returns status :ok on health check' do
      get '/api/characters'

      expect(response).to have_http_status(:ok)
    end

    context 'without relationships' do
      before(:each) do
        @character = create(:character)
        @non_character_id = 404
      end

      # GET /api/characters/:id
      it 'returns json in the correct format' do
        headers = { 'ACCEPT' => 'application/json' }
        get "/api/characters/#{@character.id}", headers: headers

        @expected = {
          "id": 1,
          "name": {
            "first": 'Kaen',
            "last": 'Yori',
            "full": 'Kaen Yori'
          },
          "age": nil,
          "height": nil,
          "weight": nil,
          "appearance": nil,
          "description": nil,
          "relationships": [],
          "date_of_birth": nil,
          "created_at": @character.created_at.to_formatted_s(:iso8601),
          "updated_at": @character.updated_at.to_formatted_s(:iso8601)
        }.to_json

        response_body = JSON.parse(response.body)

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:ok)
        expect(response_body.to_json).to eq(@expected)
      end

      it 'return not found status if character does not exist' do
        headers = { 'ACCEPT' => 'application/json' }
        get "/api/characters/#{@non_character_id}", headers: headers

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with relationships' do
      before(:each) do
        @character1, @character2, @character3 = create_list(:character, 3)
        create(:relationship, character_from_id: @character1.id, character_to_id: @character2.id)
        create(:relationship, character_from_id: @character2.id, character_to_id: @character3.id)
        create(:relationship, character_from_id: @character2.id, character_to_id: @character1.id)
      end

      # GET /api/characters/:id
      it 'returns json for relationships for basic relation' do
        headers = { 'ACCEPT' => 'application/json' }
        get "/api/characters/#{@character1.id}", headers: headers

        @expected_relationships = [2]

        response_json = JSON.parse(response.body)

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:ok)
        expect(response_json['relationships']).to eq(@expected_relationships)
      end

      # GET /api/characters/:id
      it 'returns json for complex relations' do
        headers = { 'ACCEPT' => 'application/json' }
        get "/api/characters/#{@character2.id}", headers: headers

        @expected_relationships = [3, 1]

        response_json = JSON.parse(response.body)

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:ok)
        expect(response_json['relationships']).to eq(@expected_relationships)
      end
    end
  end

  # POST create
  describe 'POST #create' do
    # TODO: Decide on a good method to validate attributes

    # POST /api/characters/
    it 'generates a new character on post' do
      headers = { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

      body = {
        "first_name": 'Kaen',
        "last_name": 'Yori',
        "age": 10,
        "height": 140,
        "weight": 102,
        "date_of_birth": nil,
        "location_of_birth": nil,
        "traits": %w[bold direct unfazed],
        "appearance": 'description of appearance',
        "description": 'The 2nd eldest Yori sibling',
        "abilities": [],
        "relationships": [],
        "events": []
      }.to_json

      post '/api/characters', headers: headers, params: body

      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:ok)
      expect(Character.all.count).to eq(1)
    end
  end

  # DELETE destroy
  describe 'DELETE #destroy' do
    before(:each) do
      @character1, @character2, @character3 = create_list(:character, 3)
      create(:relationship, character_from_id: @character1.id, character_to_id: @character2.id)
      create(:relationship, character_from_id: @character2.id, character_to_id: @character3.id)
      create(:relationship, character_from_id: @character2.id, character_to_id: @character1.id)

      @non_character_id = 404
    end

    # DELETE /api/characters/:id
    it 'removes db entry for a character' do
      headers = { 'ACCEPT' => 'application/json' }
      delete "/api/characters/#{@character1.id}", headers: headers

      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:ok)
      expect(Character.all.count).to eq(2)
      expect(Character.where(id: @character1.id)).not_to exist
    end

    # DELETE /api/characters/:id
    it 'removes associated relationships with a character' do
      headers = { 'ACCEPT' => 'application/json' }
      delete "/api/characters/#{@character1.id}", headers: headers

      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:ok)

      expect(Relationship.all.count).to eq(1)
      expect(Relationship.where(character_from_id: @character1.id)).not_to exist
      expect(Relationship.where(character_to_id: @character1.id)).not_to exist
    end

    # DELETE /api/characters/:id
    it 'returns not found status if entry does not exist' do
      headers = { 'ACCEPT' => 'application/json' }
      delete "/api/characters/#{@non_character_id}", headers: headers

      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:not_found)
    end
  end
end
