# frozen_string_literal: true

# Documentation:
# CharacterController corresponds to the respective API
class Api::CharactersController < ApiController
  # GET api/characters
  def index
    # Health check
    render json: { status: 200 }
  end

  # POST api/characters
  def create
    new_character = Character.create(character_params)
    render json: { character_id: new_character.id, status: 200 }

    # .new isn't too useful in an api
    # if new_character.save
    #   render json: { status: 200 }
    # else
    #   render json: { status: 404 }
    # end
  end

  def show
    render json: { character: character }
  end

  def update
    # update(character_params)
  end

  def destroy
    if !character.nil?
      character.destroy
      render json: { status: 200 }
    else
      render json: { status: 404 }
    end
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

  def character_with_relations
    byebug
    Character.find_by_id(params[:id]).includes(:character_from).to_a
  end

  def character_params
    params.require(:character).permit(:id, :first_name, :last_name, :traits, :appearance, :age, :description, :height,
                                      :weight, :date_of_birth)
  end
end
