# frozen_string_literal: true

# Documentation:
class Api::RelationshipsController < ApiController

    def create
       Relationship.create(relationship_params)
    end

    private

    def relationship_params
        params.require(:relationship).permit(:id, :character_from_id, :character_to_id)
    end
end
