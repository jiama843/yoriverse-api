# frozen_string_literal: true

# Documentation:
class CharactersController < ApplicationController
  def index
    @character = Character.all

    # render "characters/index"
  end

  def show; end
end
