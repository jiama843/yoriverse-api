# frozen_string_literal: true

# Documentation:
# CharacterController corresponds to the respective API
module Api
  class CharactersController < ApiController
    # GET api/characters
    def index
      # Health check
      render json: { status: 'OK' }, status: 200
    end

    # POST api/characters
    def create
      new_character = Character.create(character_params)
      render json: { character_id: new_character.id }, status: 200
    end

    # GET api/characters/:id
    def show
      render json: { status: 'Character does not exist' }, status: 404 and return if character.nil?

      render json: character.to_formatted_json, status: 200
    end

    # TODO: implement put/patch request flow
    def update; end

    def destroy
      render json: { status: 'Failed to delete character' }, status: 404 and return if character.nil?

      character.destroy
      render json: { status: 'Successfully deleted character' }, status: 200
    end

    def appearance; end

    def traits
      render json: { status: 200 }
    end

    def relationships; end

    private

    def character
      Character.find_by_id(params[:id])
    end

    def character_params
      params.require(:character).permit(:id, :first_name, :last_name, :traits, :appearance, :age, :description, :height,
                                        :weight, :date_of_birth)
    end
  end
end
