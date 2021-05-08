class Api::CharactersController < ApiController
  
  # GET api/characters
  def index
    # Health check
    render json: { status: 200 }
  end

  # POST api/characters
  def create
    new_character = Character.create(character_params)
    render json: { status: 200 }
  end

  def show
    render json: { character: character }
  end

  def update
    
  end

  def destroy
    if character.destroy
      render json: { status: 200 }
    else
      render json: { status: 404 }
    end
  end

  def appearance
  end

  def traits
    render json: { status: 200 }
  end

  def relationships
    
  end

  private

  def character
    character ||= Character.find_by_id(params[:id])
  end

  def character_params
    params.require(:character).permit(:id, :traits)
  end
end
