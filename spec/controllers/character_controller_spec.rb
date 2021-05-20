# frozen_string_literal: true

require 'rails_helper'

describe Api::CharactersController, type: :controller do
  before(:all) do
    @character = create(:character)
  end

  # GET/ ...
  describe 'GET #show' do
    context 'without relationships' do
      it 'returns json in the correct format' do
      end
    end

    context 'with relationships' do
    end
  end

  # POST/
  describe 'POST #create' do
  end
end
