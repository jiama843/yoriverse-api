class CharactersController < ApplicationController
    def new
        @character = Character.new
    end

    def create
        character = Character.create(character_params)

        redirect_to characters_path
    end

    def index
        @characters = Character.all
        
        # render "characters/index"
    end

    def show
        # For now, later it should be its own thing in show.html.erb
        #redirect_to character_path
    end

    def destroy
        byebug
        character.destroy

        redirect_to characters_path
    end

    private

    def character
        @character = Character.find_by_id(params[:id])
    end

    def character_params
        params.require(:character).permit(:id)
    end
end