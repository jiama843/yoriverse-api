class Relationship < ApplicationRecord
    belongs_to :character_from, foreign_key: :character_from_id, class_name: Character
    belongs_to :character_to, foreign_key: :character_to_id, class_name: Character
end
