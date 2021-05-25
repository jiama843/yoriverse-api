# frozen_string_literal: true

require 'rails_helper'

describe Api::CharactersController, type: :request do

  # GET #show
  describe 'GET #show' do
    # TODO: need to add before :each in contexts (create relationships)

    # GET /api/characters
    it 'returns status :ok on health check' do
        get "/api/characters"

        expect(response).to have_http_status(:ok)
    end

    context 'without relationships' do
      before(:each) do
        @character = create(:character)
      end

      # GET /api/characters/:id
      it 'returns json in the correct format' do
        headers = { "ACCEPT" => "application/json" }
        get "/api/characters/#{@character.id}", headers: headers #, params: { id: @character.id }

        @expected = {
          "id": 1,
          "name": {
            "first": "Kaen",
            "last": "Yori",
            "full": "Kaen Yori"
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

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(:ok)
        expect(response_body.to_json).to eq(@expected)
      end

      it 'return not found status if character does not exist' do
      end
    end

    context 'with relationships' do
      before(:each) do
        @character1, @character2 = create_list(:character, 2)
        @relationship = create(:relationship, character_from_id: @character1.id, character_to_id: @character2.id)
      end

      # GET /api/characters/:id
      it 'returns json for relationships' do
        headers = { "ACCEPT" => "application/json" }
        get "/api/characters/#{@character1.id}", headers: headers

        @expected_relationships = [2]

        response_json = JSON.parse(response.body)

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(:ok)
        expect(response_json["relationships"]).to eq(@expected_relationships)
      end
    end
  end

  # POST/
  describe 'POST #create' do
    # it ''
    #   body = 
  end

  # DELETE/
  # - delete character clears from db
  #     - clears associated (relationship) records
  #     - doesn't clear character records
end
