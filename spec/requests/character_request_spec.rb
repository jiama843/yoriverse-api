# frozen_string_literal: true

require 'rails_helper'

describe Api::CharactersController, type: :request do
  
  # Test that requests map to actions as expected
  describe 'routing' do
    #it { should route(:get, '/api/characters').to(action: :index) }
    #it { should route(:get, '/api/characters/1').to(action: :show) }
  end

  # GET #show
  describe 'GET #show' do
    # TODO: need to add before :each in contexts (create relationships)

    # GET /api/characters
    it 'returns status :ok on health check' do
        get "/api/characters"

        byebug
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
            uest: true
        }

        byebug
        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(:ok)
      end

      it 'return not found status if character does not exist' do
      end
    end

    context 'with relationships' do
      before(:each) do
        @character1 = create(:character)
        @character2 = create(:character)
        @relationship = create(:relationship, character_from_id: @character1.id, character_to_id: @character2.id)
      end

      it 'returns json for relationships' do

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
