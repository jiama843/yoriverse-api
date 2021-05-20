# frozen_string_literal: true

FactoryBot.define do
  factory :relationship do
    character_from_id { 1 }
    character_to_id { 2 }
  end
end
