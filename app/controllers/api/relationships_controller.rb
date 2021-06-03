# frozen_string_literal: true

# Documentation:
module Api
  class RelationshipsController < ApiController
    def create
      new_relationship = Relationship.create(relationship_params)
      render json: { relationship_id: new_relationship.id }, status: 200
    end

    def destroy
      render json: { status: 'Failed to delete relationship' }, status: 404 and return if relationship.nil?

      relationship.destroy
      render json: { status: 'Successfully deleted relationship' }, status: 200
    end

    private

    def relationship
      Relationship.find_by_id(params[:id])
    end

    def relationship_params
      params.require(:relationship).permit(:id, :character_from_id, :character_to_id)
    end
  end
end
