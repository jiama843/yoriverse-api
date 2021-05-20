# frozen_string_literal: true

require 'rails_helper'

describe Relationship, type: :model do
  before(:each) do
    @character1 = create(:character)
    @character2 = create(:character)
    @relationship = create(:relationship, character_from_id: @character1.id, character_to_id: @character2.id)
  end

  context 'validates relationship attributes' do
    # TODO: remove bad tests

    it { expect(@relationship.id).to eq(1) }

    ##########################################################

    it { should belong_to(:character_to) }
    it { should belong_to(:character_from) }
  end
end
