# frozen_string_literal: true

require 'rails_helper'

describe Character, type: :model do
  before(:each) do
    @character = create(:character)
  end

  context 'validates character attributes' do
    # Bad tests

    it { expect(@character.id).to eq(1) }
    it { expect(@character.first_name).to eq('Kaen') }
    it { expect(@character.last_name).to eq('Yori') }

    ##########################################################

    it { should have_many(:relation_tos) }
    it { should have_many(:relation_froms) }

    it { should have_many(:character_tos) }
    it { should have_many(:character_froms) }
  end
end
