# frozen_string_literal: true

class Character < ApplicationRecord
  has_many :relation_tos, class_name: 'Relationship', foreign_key: :character_from_id, inverse_of: :character_from,
                          dependent: :destroy
  has_many :character_tos, through: :relation_tos, source: :character_to

  # Inverse character relationships
  has_many :relation_froms, class_name: 'Relationship', foreign_key: :character_to_id, inverse_of: :character_to,
                            dependent: :destroy
  has_many :character_froms, through: :relation_froms, source: :character_from

  # TODO: Add location_of_birth and events involved
  def to_formatted_json
    response_body =
      {
        id: id,
        name: name_data,
        age: age,
        height: height,
        weight: weight,
        appearance: appearance&.force_encoding('utf-8'),
        description: description&.force_encoding('utf-8'),
        relationships: character_tos.pluck(:id),
        date_of_birth: date_of_birth
      }

    # Merge timestamps
    response_body.merge!(timestamps)

    response_body.to_json
  end

  private

  def name_data
    {
      first: first_name,
      last: last_name,
      full: "#{first_name} #{last_name}"
    }
  end

  def timestamps
    {
      created_at: created_at.to_formatted_s(:iso8601),
      updated_at: updated_at.to_formatted_s(:iso8601)
    }
  end
end
