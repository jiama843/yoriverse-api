# frozen_string_literal: true

class Character < ApplicationRecord
    has_many :relation_tos, foreign_key: :character_from_id, class_name: Relationship, dependent: :destroy
    has_many :character_tos, through: relation_to, source: character_to

    # Inverse character relationships
    has_many :relation_froms, foreign_key: :character_to_id, class_name: Relationship, dependent: :destroy
    has_many :character_froms, through relation_from, source: character_from

end
