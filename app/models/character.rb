# frozen_string_literal: true

class Character < ApplicationRecord
  has_many :relation_tos, class_name: 'Relationship', foreign_key: :character_from_id, inverse_of: :character_from,
                          dependent: :destroy
  has_many :character_tos, through: :relation_tos, source: :character_to

  # Inverse character relationships
  has_many :relation_froms, class_name: 'Relationship', foreign_key: :character_to_id, inverse_of: :character_to,
                            dependent: :destroy
  has_many :character_froms, through: :relation_froms, source: :character_from
end

# Old soln

# has_many :relation_to, foreign_key: :character_from_id, class_name: "Relationship", dependent: :destroy
# has_many :character_tos, through: :relation_to, source: :character_to

# # Inverse character relationships
# has_many :relation_from, foreign_key: :character_to_id, class_name: "Relationship", dependent: :destroy
# has_many :character_froms, through: :relation_from, source: :character_from
